import XCTest
@testable import CoreDataStack
import CoreData

final class CoreDataStackTests: XCTestCase {
    
    func testObjectsAreSavedAndRetrieved() {
        let stack = try! CoreDataStack(launchType: .inMemory, managedObjectModel: .testModel)
        
        let testEntity = stack.backgroundContext.testModel
        XCTAssertNoThrow(try stack.backgroundContext.save())
        
        let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest()
        let result = try! stack.backgroundContext.fetch(fetchRequest)
        
        XCTAssertFalse(result.isEmpty)
        XCTAssertTrue(result.first?.name == testEntity.name)
    }
    
    func testObjectsFromMultipleStacksDoesNotCollide() {
        let stack1 = try! CoreDataStack(launchType: .inMemory, managedObjectModel: .testModel)
        let stack2 = try! CoreDataStack(launchType: .inMemory, managedObjectModel: .testModel)

        _ = stack1.backgroundContext.testModel
        XCTAssertFalse(stack1.backgroundContext.fetchAllModels.isEmpty)
        XCTAssertTrue(stack2.backgroundContext.fetchAllModels.isEmpty)
    }

    func testThatBackgroundContextInOnMainQueue() {
        let stack = try! CoreDataStack(launchType: .inMemory, managedObjectModel: .testModel)
        XCTAssertTrue(stack.mainContext.concurrencyType == .mainQueueConcurrencyType, "Expected reader context to work on main queue")
    }

    func testThatWriterContextInOnPrivateQueue() {
        let stack = try! CoreDataStack(launchType: .inMemory, managedObjectModel: .testModel)
        XCTAssertTrue(stack.backgroundContext.concurrencyType == .privateQueueConcurrencyType, "Expected writer context to work on private queue")
    }
    
    func testRoundTrip() {
        let stack1 = try! CoreDataStack(launchType: .inMemory, managedObjectModel: .testModel)
        _ = stack1.backgroundContext.testModel
        XCTAssertNoThrow(try stack1.mainContext.save())
        XCTAssertFalse(stack1.mainContext.fetchAllModels.isEmpty)
    }
}

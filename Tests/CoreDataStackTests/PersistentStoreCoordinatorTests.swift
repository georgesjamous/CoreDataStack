import XCTest
@testable import CoreDataStack
import CoreData

final class PersistentStoreCoordinatorTests: XCTestCase {
    
    func testInMemoryCoordinatorCreation() {
        let coordinator = try! NSPersistentStoreCoordinator(inMemory: .testModel)
        XCTAssertTrue(coordinator.persistentStores.count == 1)
        XCTAssertEqual(coordinator.persistentStores.first?.type, "InMemory", "Expected to be created in memory")
    }
    
    func testOnDiskCoordinatorCreation() {
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let location = documentsDirectoryURL.appendingPathComponent("abcd")
        let coordinator = try! NSPersistentStoreCoordinator(onDisk: location, model: .testModel)
        XCTAssertTrue(coordinator.persistentStores.count == 1)
        XCTAssertEqual(coordinator.persistentStores.first?.type, "SQLite", "Expected to be created on disk SQLite")
        XCTAssertEqual(coordinator.persistentStores.first?.url?.lastPathComponent, "abcd", "Expected to find identifier in path")
    }
    
}

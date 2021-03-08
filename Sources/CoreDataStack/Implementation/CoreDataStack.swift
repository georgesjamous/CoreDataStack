import CoreData

public final class CoreDataStack: CoreDataStackProtocol {
    
    public let launchType: CoreDataStackLaunchType
    public let managedObjectModel: NSManagedObjectModel
    private let persistentStoreCoordinator: NSPersistentStoreCoordinator
    
    public init(
        launchType: CoreDataStackLaunchType,
        managedObjectModel: NSManagedObjectModel
    ) throws {
        self.launchType = launchType
        self.managedObjectModel = managedObjectModel
        self.persistentStoreCoordinator = try {
            switch launchType {
            case .inMemory:
                return try NSPersistentStoreCoordinator(inMemory: managedObjectModel)
            case .path(url: let url):
                return try NSPersistentStoreCoordinator(onDisk: url, model: managedObjectModel)
            case .onDisk(identifier: let identifier):
                let storeName = "\(identifier).sqlite"
                guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                    throw NSError(
                        domain: "com.CoreDataStack",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Could not find Default Document Directory for Application"]
                    )
                }
                let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
                return try NSPersistentStoreCoordinator(onDisk: persistentStoreURL, model: managedObjectModel)
            }
        }()
    }
    
    public lazy var backgroundContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        context.persistentStoreCoordinator = persistentStoreCoordinator
        return context
    }()
    
    public lazy var mainContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.parent = backgroundContext
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        return context
    }()
    
}

//
//  File.swift
//  
//
//  Created by Georges on 3/8/21.
//

import CoreData

extension NSPersistentStoreCoordinator {
    convenience init(inMemory model: NSManagedObjectModel) throws {
        self.init(managedObjectModel: model)
        try addPersistentStore(
            ofType: NSInMemoryStoreType,
            configurationName: nil,
            at: nil,
            options: nil
        )
    }
    convenience init(onDisk url: URL, model: NSManagedObjectModel) throws {
        self.init(managedObjectModel: model)
        try addPersistentStore(
            ofType: NSSQLiteStoreType,
            configurationName: nil,
            at: url,
            options: nil
        )
    }
}

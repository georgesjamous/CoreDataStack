//
//  File.swift
//  
//
//  Created by Georges on 3/4/21.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    var testModel: Entity {
        let testEntity = Entity(context: self)
        testEntity.name = UUID().uuidString
        return testEntity
    }
    var fetchAllModels: [Entity] {
        let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest()
        return try! fetch(fetchRequest)
    }
}

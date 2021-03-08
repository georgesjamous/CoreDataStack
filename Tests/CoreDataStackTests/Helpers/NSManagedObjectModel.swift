//
//  File.swift
//  
//
//  Created by Georges on 3/4/21.
//

import Foundation
import CoreData

extension NSManagedObjectModel {
    static var testModel: NSManagedObjectModel {
        let currentBundle: Bundle = Bundle.module
        let url = currentBundle.url(forResource: "TestModel", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: url)!
    }
}

//
//  File.swift
//  
//
//  Created by Georges on 3/8/21.
//

import Foundation
import CoreData

public protocol CoreDataStackProtocol: CoreDataStackContextProviding {
    
    /// Describes the current stack's Launch Type
    var launchType: CoreDataStackLaunchType { get }
    
    /// The managed model loaded by the stack
    var managedObjectModel: NSManagedObjectModel { get }
    
    /// Initialize the stack with a usage mode
    /// - Parameters:
    ///   - mode: the mode to use for the stack the backed storage
    ///   - model: the model to use
    init(launchType: CoreDataStackLaunchType, managedObjectModel: NSManagedObjectModel) throws
    
}

public protocol CoreDataStackContextProviding {
    
    /// This context will operate on a private queue (Background).
    /// It is optimal to use this for Reads and Writes.
    var backgroundContext: NSManagedObjectContext { get set }
    
    /// This context will operate on the main queue (Main Thread).
    /// It is optimal to use this context only for Reads.
    var mainContext: NSManagedObjectContext { get set }
    
}

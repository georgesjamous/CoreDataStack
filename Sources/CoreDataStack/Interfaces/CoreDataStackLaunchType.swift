//
//  File.swift
//  
//
//  Created by Georges on 3/8/21.
//

import Foundation

public enum CoreDataStackLaunchType {
    /// Store will be launched in memory _NSInMemoryStoreType_
    case inMemory
    /// _NSSQLiteStoreType_ will be persisted on Disk in _documentDirectory_.
    ///
    /// _.sqlite_ will be added to the file name.
    case onDisk(identifier: String)
    /// _NSSQLiteStoreType_ will be persisted on Disk at a custom path.
    case path(url: URL)
}

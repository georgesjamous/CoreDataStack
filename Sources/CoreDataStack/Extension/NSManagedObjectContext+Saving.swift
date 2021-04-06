//
//  File.swift
//  
//
//  Created by Georges on 3/4/21.
//

import Foundation
import CoreData
import Combine

public extension NSManagedObjectContext {
    /// Saves this Context and recursively saves all parent contexts up the chain.
    /// - Throws: Error if any
    func commit() throws {
        guard hasChanges else { return }
        try self.save()
        if let parentContext = self.parent {
            try parentContext.commit()
        }
    }
    /// Saves this Context and recursively saves all parent contexts up the chain.
    /// - Parameter completion: Block  called with result
    func commit(completion: @escaping (Result<Void, Error>) -> Void) {
        guard hasChanges else {
            completion(.success(Void()))
            return
        }
        perform {
            do {
                try self.commit()
                completion(.success(Void()))
            } catch {
                completion(.failure(error))
                return
            }
        }
    }
    /// A _Combine_ implementation of __NSManagedObjectContext.commitChanges__
    /// - Returns: Result of save operation
    @available(iOS 13.0, *)
    func commit() -> Future<Void, Error> {
        Future { [weak self] promise in
            guard let self = self else { return }
            self.commit { (result) in
                switch result {
                case .failure(let error):
                    promise(.failure(error))
                case .success:
                    promise(.success(Void()))
                }
            }
        }
    }
}

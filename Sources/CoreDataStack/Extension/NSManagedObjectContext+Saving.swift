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
    /// - Parameter completion: Block  called with result
    func commit(completion: @escaping (Result<Void, Error>) -> Void) {
        guard hasChanges else {
            completion(.success(Void()))
            return
        }
        perform {
            do {
                try self.save()
            } catch {
                completion(.failure(error))
                return
            }
            if let parentContext = self.parent {
                parentContext.commit(completion: completion)
            } else {
                completion(.success(Void()))
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

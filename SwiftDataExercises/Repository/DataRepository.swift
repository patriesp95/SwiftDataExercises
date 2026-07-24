//
//  DataRepository.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 24/07/2026.
//

import Foundation

protocol DataRepository: JSONStorage {
    func loadProducts() throws -> [Product]
}

extension DataRepository {
    func loadProducts() throws -> [Product] {
        return try load(type: [Product].self)
    }
}


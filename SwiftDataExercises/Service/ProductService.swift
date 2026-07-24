//
//  LocalProductService.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 24/07/2026.
//

import Foundation

protocol LocalProductService: JSONStorage {
    func loadProducts() throws -> [Product]
}

extension LocalProductService {
    func loadProducts() throws -> [Product] {
        try load(type: [Product].self)
    }
}

//
//  ProductService.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 24/07/2026.
//

import Foundation

protocol ProductService: JSONStorage {
    func loadProducts() throws -> [Product]
}

extension ProductService {
    func loadProducts() throws -> [Product] {
        try load(type: [Product].self)
    }
}

//
//  DataRepository.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 24/07/2026.
//

import Foundation

final class DataRepository {
    private let productService: any ProductService
    
    init(productService: any ProductService) {
        self.productService = productService
    }
    
    func loadProducts() throws -> [Product] {
        try productService.loadProducts()
    }
}

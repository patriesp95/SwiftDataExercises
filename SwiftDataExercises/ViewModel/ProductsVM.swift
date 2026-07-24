//
//  ProductsVM.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 24/07/2026.
//

import Foundation

@Observable
final class ProductsVM {
    var products: [Product]
    private let repository: DataRepository

    init(repository: DataRepository = DataRepository(
            productService: BundleProductService())
    ) {
        self.repository = repository

        do {
            self.products = try repository.loadProducts()
        } catch {
            self.products = []
            print(error)
        }
    }
}

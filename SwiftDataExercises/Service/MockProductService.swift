//
//  MockProductService.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 24/07/2026.
//

import Foundation

struct MockProductService: ProductService {
    var url: URL {
        Bundle.main.url(forResource: "products_test", withExtension: "json")!
    }
}

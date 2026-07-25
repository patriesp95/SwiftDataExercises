//
//  BundleProductService.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 24/07/2026.
//

import Foundation

struct BundleProductService: ProductService {
    var url: URL {
        Bundle.main.url(forResource: "products", withExtension: "json")!
    }
}

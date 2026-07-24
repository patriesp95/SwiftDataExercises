//
//  Repository.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 24/07/2026.
//

import Foundation

struct Repository: DataRepository {
    var url: URL {
        Bundle.main.url(forResource: "products", withExtension: "json")!
    }
}

struct RepositoryTest: DataRepository {
    var url: URL {
        Bundle.main.url(forResource: "products", withExtension: "json")!
    }
    
    func save(products: [Product]) throws {
        print("Se han intentado guardar \(products.count).")
    }
}

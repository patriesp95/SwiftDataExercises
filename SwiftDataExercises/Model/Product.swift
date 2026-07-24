//
//  Product.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 24/07/2026.
//

import Foundation

struct Product: Decodable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let isFavorite: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case name = "product_name"
        case description = "product_description"
        case isFavorite = "is_favorite"
    }
}

#if DEBUG
extension Product {
    static let test = Product(
        id: 1,
        name:"Compact Digital Camera",
        description: "High-resolution camera for stunning photos.",
        isFavorite:true
    )
}
#endif

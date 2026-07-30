//
//  JSONStorage.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 28/07/2026.
//

import Foundation

protocol JSONFileLoader3 {
    var url3: URL { get }
}

extension JSONFileLoader3 {
    func load3<JSON>(type: JSON.Type) throws -> JSON where JSON: Decodable {
        let data = try Data(contentsOf: url3)
        return try JSONDecoder().decode(type, from: data)

    }
}

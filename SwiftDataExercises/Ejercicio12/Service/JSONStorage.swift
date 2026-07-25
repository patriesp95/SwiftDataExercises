//
//  JSONStorage.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 24/07/2026.
//

import Foundation

protocol JSONStorage {
    var url: URL { get }
}

extension JSONStorage {
    func load<JSON>(type: JSON.Type) throws -> JSON where JSON: Decodable {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(type, from: data)

    }
}

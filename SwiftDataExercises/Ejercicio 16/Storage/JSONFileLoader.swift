//
//  JSONStorage.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 28/07/2026.
//

import Foundation

protocol JSONFileLoader {
    var url: URL { get }
}

extension JSONFileLoader {
    func load<JSON>(type: JSON.Type) throws -> JSON where JSON: Decodable {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(type, from: data)

    }
}

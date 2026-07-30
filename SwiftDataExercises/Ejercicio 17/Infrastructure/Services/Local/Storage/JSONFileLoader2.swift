//
//  JSONStorage.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 28/07/2026.
//

import Foundation

protocol JSONFileLoader2 {
    var url2: URL { get }
}

extension JSONFileLoader2 {
    func load2<JSON>(type: JSON.Type) throws -> JSON where JSON: Decodable {
        let data = try Data(contentsOf: url2)
        return try JSONDecoder().decode(type, from: data)

    }
}

//
//  CharacterEndpoint.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 26/07/2026.
//

import Foundation

let api3 = URL(string: "https://rickandmortyapi.com/api")!
let api3Fail = URL(string: "https://rickandmortyapi.com/apiiiiiiii")!

struct CharacterEndpoint3 {
    static let getCharacters3 = api3.appending(path: "/character")
    static func getCharacters3Paginated(page: Int) -> URL {
        api3Fail
            .appending(path: "character")
            .appending(queryItems: [
                URLQueryItem(name: "page", value: "\(page)")
            ])
    }
}

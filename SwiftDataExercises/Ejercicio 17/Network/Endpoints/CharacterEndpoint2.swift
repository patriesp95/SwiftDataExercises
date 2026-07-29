//
//  CharacterEndpoint.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 26/07/2026.
//

import Foundation

let api2 = URL(string: "https://rickandmortyapi.com/api")!

struct CharacterEndpoint2 {
    static let getCharacters2 = api2.appending(path: "/character")
}

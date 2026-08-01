//
//  Character.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

struct Character3: Identifiable, Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let imageURL: URL?
}

#if DEBUG
    extension Character3 {
        static let test3 = Character3(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            gender: "Male",
            imageURL: URL(
                string:
                    "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
            )
        )
    }
#endif

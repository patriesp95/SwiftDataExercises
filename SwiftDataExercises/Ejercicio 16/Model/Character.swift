//
//  Character.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

struct Character: Identifiable, Decodable {
    let id: UUID
    let name: String
    let status: String
    let species: String
    let gender: String
    let imageURL: URL?
}

#if DEBUG
    extension Character {
        static let test = Character(
                id: UUID(),
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

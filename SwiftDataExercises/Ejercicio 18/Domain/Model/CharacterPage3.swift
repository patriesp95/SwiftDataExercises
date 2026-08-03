//
//  Info.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 29/07/2026.
//
import Foundation

struct CharacterPage3 {
    var characters: [Character3]
    let nextPage: Int?
}


#if DEBUG
    extension CharacterPage3 {
        static let characterPageTest3 = CharacterPage3(
            characters: [
                Character3(
                    id: 1,
                    name: "Rick Sanchez",
                    status: "Alive",
                    species: "Human",
                    gender: "Male",
                    imageURL: URL(
                        string:
                            "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
                    )
                ),
                Character3(
                    id: 2,
                    name: "Morty Smith",
                    status: "Alive",
                    species: "Human",
                    gender: "Male",
                    imageURL: URL(
                        string:
                            "https://rickandmortyapi.com/api/character/avatar/2.jpeg"
                    )
                ),
                Character3(
                    id: 183,
                    name: "Johnny Depp",
                    status: "Alive",
                    species: "Human",
                    gender: "Male",
                    imageURL: URL(
                        string:
                            "https://rickandmortyapi.com/api/character/avatar/183.jpeg"
                    )
                )
            ],
            nextPage: 2
        )

        static let characterPagResponseEmpty3 =
            CharacterPage3(
                characters: [],
                nextPage: nil
            )
    }
#endif

//
//  Info.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 29/07/2026.
//
import Foundation

struct CharacterPage {
    var characters: [Character2]
    let nextPage: Int?
}


#if DEBUG
    extension CharacterPage {
        static let characterPageTest2 = CharacterPage(
            characters: [
                Character2(
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
            ],
            nextPage: 2
        )
        
        static let characterPagResponseEmpty2 =
            CharacterPage(
                characters: [],
                nextPage: nil
            )
    }
#endif

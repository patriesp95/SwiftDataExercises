//
//  CharacterResponseDTO.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

struct CharacterResponseDTO2: Decodable {
    let info: CharacterPageInfoDTO2
    let results: [CharacterDTO2]
}

struct CharacterPageInfoDTO2: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?

}

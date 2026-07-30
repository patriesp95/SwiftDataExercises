//
//  CharacterResponseDTO.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

struct CharacterResponseDTO3: Decodable {
    let info: CharacterPageInfoDTO3
    let results: [CharacterDTO3]
}

struct CharacterPageInfoDTO3: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?

}

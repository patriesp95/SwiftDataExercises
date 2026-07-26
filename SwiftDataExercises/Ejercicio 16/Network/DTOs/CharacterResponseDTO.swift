//
//  CharacterResponseDTO.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

struct CharacterResponseDTO: Decodable {
    let results: [CharacterDTO]
}

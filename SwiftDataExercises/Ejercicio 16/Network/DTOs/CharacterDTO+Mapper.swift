//
//  CharacterDTO+Mapper.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

extension CharacterDTO {
    func toDomain() -> Character {
        Character(
            id: UUID(),
            name: name,
            status: status,
            species: species,
            gender: gender,
            imageURL: URL(string: image)
        )
    }
    
    
}

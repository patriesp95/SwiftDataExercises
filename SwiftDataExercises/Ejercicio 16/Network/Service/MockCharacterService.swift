//
//  MockCharacterService.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

struct MockCharacterService: CharacterService {
    func loadCharacters() async throws -> [CharacterDTO] {
        return [.characterDTOTest]
    }
}

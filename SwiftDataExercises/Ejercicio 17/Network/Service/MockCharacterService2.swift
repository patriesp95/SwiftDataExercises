//
//  MockCharacterService.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

struct MockCharacterService2: CharacterService2 {
    func loadCharacters2() async throws -> [CharacterDTO2] {
        return [.characterDTOTest2]
    }
}

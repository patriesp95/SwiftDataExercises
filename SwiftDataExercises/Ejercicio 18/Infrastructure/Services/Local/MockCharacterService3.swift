//
//  MockCharacterService.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

struct MockCharacterService3: CharacterService3 {
    func loadCharacters3(page: Int) async throws -> CharacterPage3 {
        return .characterPageTest3
    }
}

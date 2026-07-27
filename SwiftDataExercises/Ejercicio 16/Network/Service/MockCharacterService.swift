//
//  MockCharacterService.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

struct MockCharacterService: CharacterService {
    let session: URLSession
    
    func loadCharacters() async throws -> [Character] {
        return [Character.test]
    }
}

//
//  BundleCharacterService.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 28/07/2026.
//

import Foundation

final class BundleCharacterService: CharacterService, JSONFileLoader {
    var url: URL {
        Bundle.main.url(forResource: "characters", withExtension: "json")!
    }
    
    func loadCharacters() async throws -> [CharacterDTO] {
        let dto = try load(type: CharacterResponseDTO.self)
        return dto.results
    }
}

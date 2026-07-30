//
//  BundleCharacterService.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 28/07/2026.
//

import Foundation

final class BundleCharacterService3: CharacterService3, JSONFileLoader3 {

    var url3: URL {
        Bundle.main.url(forResource: "characters3", withExtension: "json")!
    }
    
    func loadCharacters3(page: Int) async throws -> CharacterPage3 {
        let dto = try load3(type: CharacterResponseDTO3.self)
        return dto.toDomain()
    }
}

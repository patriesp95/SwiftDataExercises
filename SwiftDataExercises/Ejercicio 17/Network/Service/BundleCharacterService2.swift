//
//  BundleCharacterService.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 28/07/2026.
//

import Foundation

final class BundleCharacterService2: CharacterService2, JSONFileLoader2 {

    var url2: URL {
        Bundle.main.url(forResource: "characters2", withExtension: "json")!
    }
    
    func loadCharacters2(page: Int) async throws -> CharacterPage {
        let dto = try load2(type: CharacterResponseDTO2.self)
        return dto.toDomain()
    }
}

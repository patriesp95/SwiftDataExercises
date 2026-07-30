//
//  CharacterRepository.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 26/07/2026.
//

import Foundation

final class CharacterRepository3: CharacterRepository3Protocol {
    private let service3: any CharacterService3
    
    init(service3: any CharacterService3) {
        self.service3 = service3
    }

    func loadCharacters3(page: Int) async throws -> CharacterPage3 {
        try await service3.loadCharacters3(page: page)
    }
}

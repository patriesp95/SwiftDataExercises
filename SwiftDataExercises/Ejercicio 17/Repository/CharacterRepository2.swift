//
//  CharacterRepository.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 26/07/2026.
//

import Foundation

final class CharacterRepository2 {
    private let service2: any CharacterService2
    
    init(service2: any CharacterService2) {
        self.service2 = service2
    }

    func loadCharacters2() async throws -> [Character2] {
        try await service2.loadCharacters2().map { $0.toDomain() }
    }

}

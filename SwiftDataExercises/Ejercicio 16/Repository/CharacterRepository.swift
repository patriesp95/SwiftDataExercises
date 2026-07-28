//
//  CharacterRepository.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 26/07/2026.
//

import Foundation

final class CharacterRepository {
    private let service: any CharacterService
    
    init(service: any CharacterService) {
        self.service = service
    }

    func loadCharacters() async throws -> [Character] {
        try await service.loadCharacters().map { $0.toDomain() }
    }

}

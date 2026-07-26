//
//  RemoteCharacterService.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

struct RemoteCharacterService: CharacterService {
    let session: URLSession
    
    func loadCharacters() async throws -> [Character] {
        let dto = try await request(
            type: CharacterResponseDTO.self,
            URLRequest.get(url: CharacterEndpoint.getCharacters)
        )
        return dto.results.map { $0.toDomain() }
    }
}

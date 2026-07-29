//
//  RemoteCharacterService.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

struct RemoteCharacterService2: CharacterService2, APIClient2 {
    let session2: URLSession
    
    func loadCharacters2(page: Int) async throws -> CharacterPage {
        let dto = try await request2(
            type: CharacterResponseDTO2.self,
            URLRequest.get2(url: CharacterEndpoint2.getCharacters2)
        )
        return dto.toDomain()
    }
}

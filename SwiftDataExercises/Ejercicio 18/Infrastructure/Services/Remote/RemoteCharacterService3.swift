//
//  RemoteCharacterService.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

struct RemoteCharacterService3: CharacterService3, APIClient3 {
    let session3: URLSession
    
    func loadCharacters3(page: Int) async throws -> CharacterPage3 {
        do {
            let dto = try await request3(
                type: CharacterResponseDTO3.self,
                URLRequest.get3(url: CharacterEndpoint3.getCharacters3Paginated(page: page))
            )
            return dto.toDomain()
        } catch {
            throw APIError3.general(error)
        }
    }
}

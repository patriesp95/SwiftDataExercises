//
//  CharacterRepository.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 26/07/2026.
//

import Foundation

enum CharacterDataSource {
    case remote
    case local
}

final class CharacterRepository3: CharacterRepository3Protocol {
    private let remoteService: any CharacterService3
    private let localService: any CharacterService3
    private let characterDataSource: CharacterDataSource

    init(
        remoteService: any CharacterService3,
        localService: any CharacterService3,
        characterDataSource: CharacterDataSource
    ) {
        self.remoteService = remoteService
        self.localService = localService
        self.characterDataSource = characterDataSource
    }

    func loadCharacters3(page: Int) async throws -> CharacterPage3 {
        switch characterDataSource {
        case .remote:
            do {
                return try await remoteService.loadCharacters3(page: page)
            } catch let remoteError {
                do {
                    return try await localService.loadCharacters3(page: page)
                } catch let localError {
                    throw RepositoryError.fallbackFailed(
                        remote: NetworkErrorMapper.map(remoteError),
                        local: StorageErrorMapper.map(localError)
                    )
                }
            }
        case .local:
            do {
                return try await localService.loadCharacters3(page: page)
            } catch {
                throw RepositoryError.local(
                    StorageErrorMapper.map(error)
                )
            }
        }
    }
}

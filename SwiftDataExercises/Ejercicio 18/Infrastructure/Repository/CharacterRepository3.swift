//
//  CharacterRepository.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 26/07/2026.
//

import Foundation

enum DataSource {
    case remote
    case local
}

final class CharacterRepository3: CharacterRepository3Protocol {
    private let remoteService: any CharacterService3
    private let localService: any CharacterService3
    private let dataSource: DataSource

    init(
        remoteService: any CharacterService3,
        localService: any CharacterService3,
        dataSource: DataSource
    ) {
        self.remoteService = remoteService
        self.localService = localService
        self.dataSource = dataSource
    }

    func loadCharacters3(page: Int) async throws -> CharacterPage3 {
        switch dataSource {
            case .remote:
                do {
                    return try await remoteService.loadCharacters3(page: page)
                } catch {
                    return try await localService.loadCharacters3(page: page)
                }
            case .local:
                return try await localService.loadCharacters3(page: page)
            }
    }
}

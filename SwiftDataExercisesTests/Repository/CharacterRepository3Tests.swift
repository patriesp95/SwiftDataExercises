//
//  CharacterRepository3Tests.swift
//  SwiftDataExercisesTests
//
//  Created by Patricia M Espert on 03/08/2026.
//

import Foundation
import Testing

@testable import SwiftDataExercises

@MainActor
struct CharacterRepository3Tests {

    @Test("Remote service works")
    func remoteServiceWorks() async throws {

        //Given
        let remoteService = MockCharacterService3(
            result: .success(.characterPageTest3)
        )
        let localService = MockCharacterService3(
            result: .success(.characterPagResponseEmpty3)
        )

        let sut = CharacterRepository3(
            remoteService: remoteService,
            localService: localService,
            characterDataSource: .remote
        )

        //When
        let result = try await sut.loadCharacters3(page: 1)

        //Then
        #expect(result.characters == CharacterPage3.characterPageTest3.characters)
        #expect(result.nextPage == CharacterPage3.characterPageTest3.nextPage)
        #expect(remoteService.callCount == 1)
        #expect(localService.callCount == 0)
        #expect(remoteService.receivedPage == 1)
    }
    
    @Test("Local service works")
    func localServiceWorks() async throws {

        //Given
        let remoteService = MockCharacterService3(
            result: .success(.characterPageTest3)
        )
        let localService = MockCharacterService3(
            result: .success(.characterPageTest3)
        )

        let sut = CharacterRepository3(
            remoteService: remoteService,
            localService: localService,
            characterDataSource: .local
        )

        //When
        let result = try await sut.loadCharacters3(page: 1)

        //Then
        #expect(result.characters == CharacterPage3.characterPageTest3.characters)
        #expect(result.nextPage == CharacterPage3.characterPageTest3.nextPage)
        #expect(remoteService.callCount == 0)
        #expect(localService.callCount == 1)
        #expect(localService.receivedPage == 1)
    }
    
    @Test("Local service works therefore remote service fails")
    func localServiceWorksRemoteServiceFails() async throws {

        //Given
        let remoteService = MockCharacterService3(
            result: .failure(NetworkError.httpStatus(code: 500))
        )
        let localService = MockCharacterService3(
            result: .success(.characterPageTest3)
        )

        let sut = CharacterRepository3(
            remoteService: remoteService,
            localService: localService,
            characterDataSource: .remote
        )

        //When
        let result = try await sut.loadCharacters3(page: 1)

        //Then
        #expect(result.characters == CharacterPage3.characterPageTest3.characters)
        #expect(result.nextPage == CharacterPage3.characterPageTest3.nextPage)
        #expect(remoteService.callCount == 1)
        #expect(localService.callCount == 1)
        #expect(remoteService.receivedPage == 1)
        #expect(localService.receivedPage == 1)
    }

    @Test("Local service fails and remote service fails")
    func localServiceFailsAndRemoteServiceFails() async throws {

        //Given
        let remoteService = MockCharacterService3(
            result: .failure(NetworkError.httpStatus(code: 500))
        )
        let localService = MockCharacterService3(
            result: .failure(StorageError.corruptedJson)
        )

        let sut = CharacterRepository3(
            remoteService: remoteService,
            localService: localService,
            characterDataSource: .remote
        )

        //When / Then
        do {
            _ = try await sut.loadCharacters3(page: 1)
        } catch {
            switch error {
                case RepositoryError.fallbackFailed(let remoteError, let localError):
                    #expect(remoteError.statusCode == 500, "Expected 500, got \(remoteError)")
                    #expect(localError.localizedDescription == StorageError.corruptedJson.localizedDescription)
            default:
                Issue.record("Expected RepositoryError.fallbackFailed, got: \(error)")
            }
        }
        
    }
    
    @Test("Repository forwards requested page to service")
    func pageIsForwadedCorrectly() async throws {

        //Given
        let remoteService = MockCharacterService3(
            result: .success(.characterPageTest3)
        )
        let localService = MockCharacterService3(
            result: .success(.characterPagResponseEmpty3)
        )

        let sut = CharacterRepository3(
            remoteService: remoteService,
            localService: localService,
            characterDataSource: .remote
        )
        
        let requestedPage = 7

        //When
        let _ = try await sut.loadCharacters3(page: requestedPage)

        //Then
        #expect(remoteService.receivedPage == requestedPage)
    }

}

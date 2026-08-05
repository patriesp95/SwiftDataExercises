//
//  CharacterViewModel3Tests.swift
//  SwiftDataExercisesTests
//
//  Created by Patricia M Espert on 04/08/2026.
//

import Foundation
import Testing

@testable import SwiftDataExercises

@MainActor
struct CharacterViewModel3Tests {

    @Test("Initial loading")
    func initialLoading() async throws {
        
        //Given
        let useCase = MockLoadAndSortCharactersUseCase3(result: .success(.characterPageTest3))
        let sut = CharacterViewModel3(loadAndSortCharactersUseCase: useCase)
        let expectedCharacters = CharacterPage3.characterPageTest3.characters
        
        //When
        
        sut.isLoadingInitialPage = true
        let _ = await sut.getCharacters3()
        sut.isLoadingInitialPage = false
        
        //Then
        switch sut.loadingState {
            case .loaded(let characters):
                #expect(characters == expectedCharacters)
            case .loading:
                Issue.record("Expected loadingState to be .loaded, got: .loading")
            case .empty:
                Issue.record("Expected loadingState to be .loaded, got: .empty")
            default:
                Issue.record("Expected loadingState to be .loaded, got: \(sut.loadingState)")
        }
        
        #expect(useCase.callCount == 1)
        #expect(useCase.receivedPage == 1)
    }
}

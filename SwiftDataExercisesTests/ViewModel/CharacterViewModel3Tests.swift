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
    
    @Test("Initial state")
    func initialState() async throws {
        
        //Given
        let useCase = MockLoadAndSortCharactersUseCase3(result: .success(.characterPageTest3))
        let sut = CharacterViewModel3(loadAndSortCharactersUseCase: useCase)
        
        //When
        
        //Then
        switch sut.loadingState {
            case .idle:
                #expect(sut.characters3.characters == [])
                #expect(sut.characters3.nextPage == nil)
            default:
                Issue.record("Expected loadingState to be .loaded, got: \(sut.loadingState)")
        }
        
    }

    @Test("Initial loading works")
    func initialLoadingWorks() async throws {
        
        //Given
        let useCase = MockLoadAndSortCharactersUseCase3(result: .success(.characterPageTest3))
        let sut = CharacterViewModel3(loadAndSortCharactersUseCase: useCase)
        let expectedCharacters = CharacterPage3.characterPageTest3.characters
        
        //When
        await sut.loadInitial()

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
        #expect(useCase.receivedPages == [1])
    }

    @Test("ViewModel shows empty state when use case returns no characters")
    func showsEmptyStateWhenUseCaseReturnsNoCharacters() async throws {
        
        //Given
        let useCase = MockLoadAndSortCharactersUseCase3(result: .success(.characterPagResponseEmpty3))
        let sut = CharacterViewModel3(loadAndSortCharactersUseCase: useCase)
        let expectedCharacters = CharacterPage3.characterPagResponseEmpty3.characters
        
        //When
        await sut.loadInitial()

        //Then
        switch sut.loadingState {
            case .empty:
                #expect(expectedCharacters == [])
                #expect(sut.characters3.nextPage == nil)
            default:
                Issue.record("Expected loadingState to be .empty, got: \(sut.loadingState)")
        }
        
        #expect(useCase.callCount == 1)
        #expect(useCase.receivedPages == [1])
    }

    @Test("ViewModel shows an error during initial loading")
    func showsAnErrorDuringInitialLoadingOfCharacters() async throws {
        
        //Given
        let useCase = MockLoadAndSortCharactersUseCase3(result: .failure(RepositoryError.noDataAvailable))
        let sut = CharacterViewModel3(loadAndSortCharactersUseCase: useCase)
        let expectedCharacters = CharacterPage3.characterPagResponseEmpty3.characters
        
        //When
        await sut.loadInitial()

        //Then
        #expect(sut.characters3.characters == expectedCharacters)
        #expect(sut.isLoadingInitialPage == false)
        #expect(!sut.errorMsg3.isEmpty)
        #expect(sut.showError3 == true)
        #expect(useCase.callCount == 1)
    }
    
    @Test("ViewModel shows nextpage when usecase receives it")
    func showsNextpageWhenUsecaseReceivesIt() async throws {
        
        //Given
        let useCase = MockLoadAndSortCharactersUseCase3(results: [
            .success(.characterPageTest3),
            .success(.characterPageTest3Page2)
        ])
        let sut = CharacterViewModel3(loadAndSortCharactersUseCase: useCase)
        let existingIDs = Set(CharacterPage3.characterPageTest3.characters.map { $0.id })
        let expected = CharacterPage3.characterPageTest3.characters
            + CharacterPage3.characterPageTest3Page2.characters.filter { !existingIDs.contains($0.id) }

        //When
        await sut.loadInitial()
        await sut.loadNextPage()

        //Then
        #expect(sut.characters3.characters == expected)
        #expect(sut.nextPage == 3)
        #expect(useCase.callCount == 2)
        #expect(useCase.receivedPages == [1, 2])
    }
    
    @Test("ViewModel shows lastpage")
    func showsLastPage() async throws {
        
        //Given
        let useCase = MockLoadAndSortCharactersUseCase3(result: .success(.characterPageTest3EOF))
        let sut = CharacterViewModel3(loadAndSortCharactersUseCase: useCase)
        let expectedCharacters = CharacterPage3.characterPageTest3EOF.characters
        

        //When
        await sut.loadInitial()
        await sut.loadNextPage()

        //Then
        #expect(sut.characters3.characters == expectedCharacters)
        #expect(sut.hasMorePages == false)
        #expect(sut.nextPage == nil)
        #expect(useCase.callCount == 1)
        #expect(useCase.receivedPages == [1])
    }
    
    @Test("While a character loading is active , loading next page doesn't call api again")
    func loadNextPageDoesNotTriggerASecondCallToApi() async throws {

        //Given
        let useCase = MockLoadAndSortCharactersUseCase3(result: .success(.characterPageTest3))
        let sut = CharacterViewModel3(loadAndSortCharactersUseCase: useCase)
        let expectedCharacters = CharacterPage3.characterPageTest3.characters

        //When
        useCase.suspendNextCall()
        async let initial: Void = sut.loadInitial()
        await useCase.waitForCallStart()

        // loadNextPage llamado mientras loadInitial sigue en vuelo — no debe disparar otra petición
        await sut.loadNextPage()

        useCase.resume()
        await initial

        //Then
        #expect(sut.characters3.characters == expectedCharacters)
        #expect(useCase.callCount == 1)
        #expect(useCase.receivedPages == [1])
    }
}

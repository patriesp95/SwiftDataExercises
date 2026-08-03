//
//  LoadAndSortCharactersUseCaseTests.swift
//  SwiftDataExercisesTests
//
//  Created by Patricia M Espert on 03/08/2026.
//

import  Foundation
import Testing
@testable import  SwiftDataExercises

@MainActor
struct LoadAndSortCharactersUseCaseTests {

    @Test("Check if the sorting works")
    func sortsCharactersAscending() async throws {
        
        //Given
        let repository = MockRepository()
        let sut = LoadAndSortCharactersUseCase3(repository: repository)
        let expectedCharacters: [Character3] = Character3.test3List.sorted { $0.name < $1.name }

        //When
        let result = try await sut.execute(page: 1)

        //Then
        #expect(expectedCharacters == result.characters)
    }
    
    @Test("Check if the sorting works even if repo returns an empty list")
    func emptyList() async throws {
        
        //Given
        let repository = MockRepositoryEmptyList()
        let sut = LoadAndSortCharactersUseCase3(repository: repository)
        let characters: [Character3] = []

        //When
        let result = try await sut.execute(page: 1)

        //Then
        #expect(characters == result.characters)
    }
    
    @Test("Check if usecase spreads the error thrown by repository")
    func errorSpreaded() async throws {
        
        //Given
        let repository = MockRepositoryThrowingError()
        let sut = LoadAndSortCharactersUseCase3(repository: repository)
        
        //When / Then
        do {
            _ = try await sut.execute(page: 1)
        } catch {
            switch error {
            case NetworkError.httpStatus(let code):
                #expect(code == 404, "Expected 404, got \(code)")
            default:
                #expect(Bool(false), "Expected NetworkError.httpStatus, got: \(error)")
            }
        }
    }
}





struct MockRepository: CharacterRepository3Protocol {
    func loadCharacters3(page: Int) async throws -> SwiftDataExercises.CharacterPage3 {
        return .characterPageTest3
    }
}

struct MockRepositoryEmptyList: CharacterRepository3Protocol {
    func loadCharacters3(page: Int) async throws -> SwiftDataExercises.CharacterPage3 {
        return .characterPagResponseEmpty3
    }
}

struct MockRepositoryThrowingError: CharacterRepository3Protocol {
    func loadCharacters3(page: Int) async throws -> SwiftDataExercises.CharacterPage3 {
        throw NetworkError.httpStatus(code: 404)
    }
}

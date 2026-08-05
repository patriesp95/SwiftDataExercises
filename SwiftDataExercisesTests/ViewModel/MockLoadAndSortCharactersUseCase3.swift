//
//  MockLoadAndSortCharactersUseCase3.swift
//  SwiftDataExercisesTests
//
//  Created by Patricia M Espert on 04/08/2026.
//


import Foundation
@testable import SwiftDataExercises

@MainActor
final class MockLoadAndSortCharactersUseCase3: LoadAndSortCharactersUseCase3Protocol {
    
    private(set) var callCount = 0
    private(set) var receivedPage: Int?
    private(set) var result: Result<CharacterPage3, Error>
    
    init(result: Result<CharacterPage3, Error>) {
        self.result = result
    }
    
    func execute(page: Int) async throws -> SwiftDataExercises.CharacterPage3 {
        callCount += 1
        receivedPage = page
        return try result.get()
    }
    
}

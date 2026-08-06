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
    private(set) var receivedPages: [Int] = []
    var results: [Result<CharacterPage3, Error>]

    init(results: [Result<CharacterPage3, Error>]) {
        self.results = results
    }

    convenience init(result: Result<CharacterPage3, Error>) {
        self.init(results: [result])
    }

    func execute(page: Int) async throws -> CharacterPage3 {
        receivedPages.append(page)
        defer { callCount += 1 }
        let result = results[min(callCount, results.count - 1)]
        return try result.get()
    }
}

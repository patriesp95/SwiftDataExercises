//
//  MockCharacterService3.swift
//  SwiftDataExercisesTests
//
//  Created by Patricia M Espert on 03/08/2026.
//

import Foundation
@testable import SwiftDataExercises

final class MockCharacterService3: CharacterService3 {
    
    private(set) var callCount = 0
    private(set) var receivedPage: Int?
    private let result: Result<CharacterPage3, Error>
    
    init(result: Result<CharacterPage3, Error>) {
        self.result = result
    }
    
    func loadCharacters3(page: Int) async throws -> SwiftDataExercises.CharacterPage3 {
        callCount += 1
        receivedPage = page
        return try result.get()
    }
}

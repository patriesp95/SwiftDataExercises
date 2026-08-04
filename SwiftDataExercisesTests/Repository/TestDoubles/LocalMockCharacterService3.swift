//
//  LocalMockCharacterService3.swift
//  SwiftDataExercisesTests
//
//  Created by Patricia M Espert on 03/08/2026.
//

import Foundation
@testable import SwiftDataExercises

final class LocalMockCharacterService3: CharacterService3 {
    func loadCharacters3(page: Int) async throws -> SwiftDataExercises.CharacterPage3 {
        return .characterPagResponseEmpty3
    }
}

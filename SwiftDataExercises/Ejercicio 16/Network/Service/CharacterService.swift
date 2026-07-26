//
//  CharacterService.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation


protocol CharacterService: APIClient {
    func loadCharacters() async throws -> [Character]
}

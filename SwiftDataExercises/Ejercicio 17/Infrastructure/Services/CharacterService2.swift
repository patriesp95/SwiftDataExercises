//
//  CharacterService.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation


protocol CharacterService2 {
    func loadCharacters2(page: Int) async throws -> CharacterPage
}


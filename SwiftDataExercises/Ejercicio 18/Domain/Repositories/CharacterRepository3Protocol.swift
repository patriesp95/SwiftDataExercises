//
//  CharacterRepository3Protocol.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 30/07/2026.
//

import Foundation

protocol CharacterRepository3Protocol {
    func loadCharacters3(page: Int) async throws -> CharacterPage3
}

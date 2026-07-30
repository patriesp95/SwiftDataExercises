//
//  CharacterRepository2Protocol.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 30/07/2026.
//

import Foundation

protocol CharacterRepository2Protocol {
    func loadCharacters2(page: Int) async throws -> CharacterPage
}

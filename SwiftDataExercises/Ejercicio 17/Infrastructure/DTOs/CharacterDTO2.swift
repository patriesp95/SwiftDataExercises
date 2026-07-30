//
//  CharacterDTO.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

struct CharacterDTO2: Decodable, Identifiable {
    let id: UUID
    let name: String
    let status: String
    let species: String
    let type: String?
    let gender: String
    let origin: LocationDTO2
    let location: LocationDTO2
    let image: String
    let episode: [String]
    let url: String
    let created: String
}




//
//  CharacterDTO.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

struct CharacterDTO3: Decodable, Identifiable, Equatable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String?
    let gender: String
    let origin: LocationDTO3
    let location: LocationDTO3
    let image: String
    let episode: [String]
    let url: String
    let created: String
}




//
//  CharacterDTO.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

struct Info2: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Results2: Decodable {
    let results: [CharacterDTO2]
}

struct CharacterDTO2: Decodable, Identifiable {
    let id: Int
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




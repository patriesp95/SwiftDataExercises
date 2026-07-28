//
//  CharacterDTO+Mapper.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

extension CharacterDTO {
    func toDomain() -> Character {
        Character(
            id: UUID(),
            name: name,
            status: status,
            species: species,
            gender: gender,
            imageURL: URL(string: image)
        )
    }
    
#if DEBUG
    static let characterDTOTest = CharacterDTO(
        id: 1,
        name: "Rick Sanchez",
        status: "Alive",
        species: "Human",
        type: "",
        gender: "Male",
        origin: LocationDTO(
            name: "Earth",
            url: "https://rickandmortyapi.com/api/location/1"
        ),
        location: LocationDTO(
            name: "Earth",
            url: "https://rickandmortyapi.com/api/location/20"
        ),
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        episode: [
            "https://rickandmortyapi.com/api/episode/1",
            "https://rickandmortyapi.com/api/episode/2"
        ],
        url: "https://rickandmortyapi.com/api/character/1",
        created: "2017-11-04T18:48:46.250Z"
    )
#endif

    
    
}

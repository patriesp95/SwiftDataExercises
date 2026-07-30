//
//  CharacterResponseDTO3+Mapper.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 29/07/2026.
//

import Foundation

extension CharacterResponseDTO3 {
    func toDomain() -> CharacterPage3 {
        CharacterPage3(
            characters: results.map { $0.toDomain() },
            nextPage: info.next.flatMap(Self.pageNumber(from:))
        )
    }

    nonisolated private static func pageNumber(from urlString: String) -> Int? {
        guard let components = URLComponents(string: urlString),
              let pageValue = components.queryItems?.first(where: { $0.name == "page" })?.value
        else { return nil }
        return Int(pageValue)
    }

    #if DEBUG
    static let characterResponseDTOtest3 = CharacterResponseDTO3(
        info: CharacterPageInfoDTO3(
            count: 826,
            pages: 42,
            next: "https://rickandmortyapi.com/api/character?page=2",
            prev: nil),
        results: [
            CharacterDTO3(
                id: 1,
                name: "Rick Sanchez",
                status: "Alive",
                species: "Human",
                type: "",
                gender: "Male",
                origin: LocationDTO3(
                    name: "Earth",
                    url: "https://rickandmortyapi.com/api/location/1"
                ),
                location: LocationDTO3(
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
        ]
    )
    #endif

}

//
//  LoadCharactersUseCase.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 29/07/2026.
//

import Foundation

protocol LoadAndSortCharactersUseCase3Protocol {
    func execute(page: Int) async throws -> CharacterPage3
}

struct LoadAndSortCharactersUseCase3: LoadAndSortCharactersUseCase3Protocol {

    private let repository: CharacterRepository3Protocol

    init(repository: CharacterRepository3Protocol) {
        self.repository = repository
    }

    func execute(page: Int) async throws -> CharacterPage3 {
        let characterResponse = try await repository.loadCharacters3(page: page)
        let sortedCharacters = characterResponse.characters.sorted { $0.name < $1.name }
        //para orden descendente Z - A
        //let sortedCharacters = characterResponse.characters.sorted { $0.name > $1.name }
        return CharacterPage3(characters: sortedCharacters, nextPage: characterResponse.nextPage)
    }

}

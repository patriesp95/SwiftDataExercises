//
//  LoadCharactersUseCase.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 29/07/2026.
//

import Foundation

protocol LoadAndSortCharactersUseCaseProtocol {
    func execute(page: Int) async throws -> CharacterPage
}

struct LoadAndSortCharactersUseCase: LoadAndSortCharactersUseCaseProtocol {

    private let repository: CharacterRepository2

    init(repository: CharacterRepository2) {
        self.repository = repository
    }

    func execute(page: Int) async throws -> CharacterPage {
        let characterResponse = try await repository.loadCharacters2(page: page)
        let sortedCharacters = characterResponse.characters.sorted { $0.name < $1.name }
        //para orden descendente Z - A
        //let sortedCharacters = characterResponse.characters.sorted { $0.name > $1.name }
        return CharacterPage(characters: sortedCharacters, nextPage: characterResponse.nextPage)
    }

}

//
//  CharacterViewModel.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 26/07/2026.
//

import Foundation

enum ViewState {
    case loading
    case loaded
    case empty
}

@Observable @MainActor
final class CharacterViewModel {
    
    let repository: CharacterRepository
    
    var characters: [Character] = []
    
    var state: ViewState = .loading

    var showError = false
    var errorMsg = ""
    
    init(repository: CharacterRepository) {
        self.repository = repository
    }

    convenience init() {
        self.init(repository: CharacterRepository(service: RemoteCharacterService(session: .shared)))
    }
    
    func getCharacters() async {
        do {
            self.characters = try await repository.loadCharacters()
            state = .loaded
        } catch {
            errorMsg = error.localizedDescription
            showError.toggle()
        }
           
        if characters.isEmpty {
            state = .empty
        }
    }
    
}

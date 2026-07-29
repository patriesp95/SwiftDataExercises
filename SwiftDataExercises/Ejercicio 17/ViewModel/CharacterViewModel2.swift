//
//  CharacterViewModel.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 26/07/2026.
//

import Foundation

enum ViewState2 {
    case loading2
    case loaded2
    case empty2
}

@Observable @MainActor
final class CharacterViewModel2 {
    
    let repository2: CharacterRepository2
    
    var characters2: [Character2] = []
    
    var state2: ViewState2 = .loading2

    var showError2 = false
    var errorMsg2 = ""
    
    init(repository2: CharacterRepository2) {
        self.repository2 = repository2
    }

    convenience init() {
        self.init(repository2: CharacterRepository2(service2: BundleCharacterService2()))
    }
    
    func getCharacters2() async {
        do {
            self.characters2 = try await repository2.loadCharacters2()
            state2 = .loaded2
        } catch {
            errorMsg2 = error.localizedDescription
            showError2 = true
        }
           
        if characters2.isEmpty {
            state2 = .empty2
        }
    }
    
}

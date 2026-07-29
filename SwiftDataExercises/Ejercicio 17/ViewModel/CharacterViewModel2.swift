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
    
    let loadAndSortCharactersUseCase: LoadAndSortCharactersUseCase
    
    var characters2: CharacterPage = .characterPagResponseEmpty2

    var state2: ViewState2 = .loading2
    
    var isLoadingInitialPage = false
    var isLoadingNextPage = false
    var hasMorePages = true
    private var currentPage = 0

    var showError2 = false
    var errorMsg2 = ""

    init(loadAndSortCharactersUseCase: LoadAndSortCharactersUseCase) {
        self.loadAndSortCharactersUseCase = loadAndSortCharactersUseCase
    }

    convenience init() {
        self.init(loadAndSortCharactersUseCase:
            LoadAndSortCharactersUseCase(
                repository:
                    CharacterRepository2(
                        service2:
                            BundleCharacterService2()
                    )
            )
        )
    }
    
    func getCharacters2() async {
        do {
            self.characters2 = try await loadAndSortCharactersUseCase.execute(page: currentPage)
            state2 = .loaded2
        } catch {
            errorMsg2 = error.localizedDescription
            showError2 = true
        }
           
        if characters2.characters.isEmpty {
            state2 = .empty2
        }
    }
    
}

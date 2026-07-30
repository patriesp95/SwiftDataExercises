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
    private var currentPage = 1
    private var nextPage: Int? = 1

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
                            RemoteCharacterService2(session2: .shared)
                    )
            )
        )
    }
    
    func getCharacters2() async {
        if isLoadingInitialPage {
            state2 = .loading2
        }
        do {
            if isLoadingInitialPage {
                self.characters2 = try await loadAndSortCharactersUseCase.execute(page: 1)
                self.nextPage = characters2.nextPage
                state2 = .loaded2
            } else {
                guard let nextPage = self.nextPage else { hasMorePages = false; return }
                if isLoadingNextPage && hasMorePages {
                    let nextPageResponse = try await loadAndSortCharactersUseCase.execute(page: nextPage)
                    self.characters2.characters.append(contentsOf: nextPageResponse.characters)
                    self.nextPage = nextPageResponse.nextPage
                    self.hasMorePages = nextPageResponse.nextPage != nil
                    state2 = .loaded2
                } else if isLoadingNextPage && !hasMorePages {
                    print("hemos llegado al final.")
                    state2 = .loaded2
                }
            }
        } catch is CancellationError {
            // La Task fue cancelada por SwiftUI (p.ej. la vista se destruyó). No es un error del usuario.
        } catch let urlError as URLError where urlError.code == .cancelled {
            // URLSession cancelada. Idem.
        } catch let apiError as APIError2 {
            if case .general(let underlying) = apiError,
               (underlying is CancellationError) ||
               ((underlying as? URLError)?.code == .cancelled) {
                return
            }
            errorMsg2 = apiError.localizedDescription
            showError2 = true
        } catch {
            print(error.localizedDescription)
            errorMsg2 = error.localizedDescription
            showError2 = true
        }

        if characters2.characters.isEmpty {
            state2 = .empty2
        }
    }
    
}

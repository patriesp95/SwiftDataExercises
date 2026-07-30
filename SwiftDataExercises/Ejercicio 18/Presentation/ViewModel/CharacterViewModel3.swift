//
//  CharacterViewModel.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 26/07/2026.
//

import Foundation

enum ViewState3 {
    case loading3
    case loaded3
    case empty3
}

@Observable @MainActor
final class CharacterViewModel3 {

    let loadAndSortCharactersUseCase: LoadAndSortCharactersUseCase3

    var characters3: CharacterPage3 = .characterPagResponseEmpty3

    var state3: ViewState3 = .loading3

    var isLoadingInitialPage = false
    var isLoadingNextPage = false
    var hasMorePages = true
    private var currentPage = 1
    private var nextPage: Int? = 1

    var showError3 = false
    var errorMsg3 = ""

    init(loadAndSortCharactersUseCase: LoadAndSortCharactersUseCase3) {
        self.loadAndSortCharactersUseCase = loadAndSortCharactersUseCase
    }

    convenience init() {
        self.init(
            loadAndSortCharactersUseCase:
                LoadAndSortCharactersUseCase3(
                    repository:
                        CharacterRepository3(
                            remoteService: RemoteCharacterService3(
                                session3: .shared
                            ),
                            localService: BundleCharacterService3(),
                            dataSource: .remote
                        )
                )
        )
    }

    func getCharacters3() async {
        if isLoadingInitialPage {
            state3 = .loading3
        }
        do {
            if isLoadingInitialPage {
                self.characters3 =
                    try await loadAndSortCharactersUseCase.execute(page: 1)
                self.nextPage = characters3.nextPage
                state3 = .loaded3
            } else {
                guard let nextPage = self.nextPage else {
                    hasMorePages = false
                    return
                }
                if isLoadingNextPage && hasMorePages {
                    let nextPageResponse =
                        try await loadAndSortCharactersUseCase.execute(
                            page: nextPage
                        )
                    self.characters3.characters.append(
                        contentsOf: nextPageResponse.characters
                    )
                    self.nextPage = nextPageResponse.nextPage
                    self.hasMorePages = nextPageResponse.nextPage != nil
                    state3 = .loaded3
                } else if isLoadingNextPage && !hasMorePages {
                    state3 = .loaded3
                }
            }
        } catch is CancellationError {
            // La Task fue cancelada por SwiftUI (p.ej. la vista se destruyó). No es un error del usuario.
        } catch let urlError as URLError where urlError.code == .cancelled {
            // URLSession cancelada. Idem.
        } catch let apiError as APIError3 {
            if case .general(let underlying) = apiError,
                (underlying is CancellationError)
                    || ((underlying as? URLError)?.code == .cancelled)
            {
                return
            }
            errorMsg3 = apiError.localizedDescription
            showError3 = true
        } catch {
            print(error.localizedDescription)
            errorMsg3 = error.localizedDescription
            showError3 = true
        }

        if characters3.characters.isEmpty {
            state3 = .empty3
        }
    }

}

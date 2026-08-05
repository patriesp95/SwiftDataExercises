//
//  CharacterViewModel.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 26/07/2026.
//

import Foundation

@Observable @MainActor
final class CharacterViewModel3 {

    let loadAndSortCharactersUseCase: LoadAndSortCharactersUseCase3Protocol

    var characters3: CharacterPage3 = .characterPagResponseEmpty3

    var loadingState: LoadingState<[Character3]> = .loading

    var isLoadingInitialPage = false
    var isLoadingNextPage = false
    var hasMorePages = true
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
                            characterDataSource: .remote
                        )
                )
        )
    }

    func getCharacters3() async {
        if isLoadingInitialPage {
            loadingState = .loading
        }
        do {
            if isLoadingInitialPage {
                self.characters3 =
                    try await loadAndSortCharactersUseCase.execute(page: 1)
                self.nextPage = characters3.nextPage
                loadingState = .loaded(characters3.characters)
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
                    // Solución: usar map + filter para evitar duplicados y mantener orden
                    let existingIDs = Set(self.characters3.characters.map { $0.id })
                    let merged = self.characters3.characters + nextPageResponse.characters.filter { !existingIDs.contains($0.id) }
                    self.characters3.characters = merged
                    self.nextPage = nextPageResponse.nextPage
                    self.hasMorePages = nextPageResponse.nextPage != nil
                    loadingState = .loaded(characters3.characters)
                } else if isLoadingNextPage && !hasMorePages {
                    loadingState = .loaded(characters3.characters)
                }
            }
        } catch is CancellationError {
            // La Task fue cancelada por SwiftUI (p.ej. la vista se destruyó). No es un error del usuario.
        } catch let urlError as URLError where urlError.code == .cancelled {
            // URLSession cancelada. Idem.
        } catch let apiError as NetworkError {
            if case .unknown(let underlying) = apiError,
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
            loadingState = .empty
        }
    }

}

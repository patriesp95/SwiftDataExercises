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

    private(set) var characters3: CharacterPage3 = .characterPagResponseEmpty3

    var loadingState: LoadingState<[Character3]> = .idle

    private(set) var isLoadingInitialPage = false
    private(set) var isLoadingNextPage = false
    private(set) var hasMorePages = true
    private(set) var nextPage: Int?

    var showError3 = false
    var errorMsg3 = ""

    init(loadAndSortCharactersUseCase: LoadAndSortCharactersUseCase3Protocol) {
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

    func loadInitial() async {
        guard !isLoadingInitialPage else { return }
        resetState()
        isLoadingInitialPage = true
        loadingState = .loading
        defer { isLoadingInitialPage = false }

        do {
            let page = try await loadAndSortCharactersUseCase.execute(page: 1)
            characters3 = page
            nextPage = page.nextPage
            hasMorePages = page.nextPage != nil
            loadingState =
                page.characters.isEmpty ? .empty : .loaded(page.characters)
        } catch {
            handle(error: error)
        }
    }

    func loadNextPage() async {
        guard hasMorePages,
            !isLoadingNextPage,
            !isLoadingInitialPage,
            let nextPage
        else { return }

        isLoadingNextPage = true
        defer { isLoadingNextPage = false }

        do {
            let response = try await loadAndSortCharactersUseCase.execute(
                page: nextPage
            )
            let existingIDs = Set(characters3.characters.map { $0.id })
            let merged =
                characters3.characters
                + response.characters.filter { !existingIDs.contains($0.id) }
            characters3.characters = merged
            self.nextPage = response.nextPage
            hasMorePages = response.nextPage != nil
            loadingState = .loaded(characters3.characters)
        } catch {
            handle(error: error)
        }
    }

    private func resetState() {
        characters3 = .characterPagResponseEmpty3
        nextPage = nil
        hasMorePages = true
        showError3 = false
        errorMsg3 = ""
    }

    private func handle(error: Error) {
        if error is CancellationError { return }
        if let urlError = error as? URLError, urlError.code == .cancelled {
            return
        }
        if let apiError = error as? NetworkError,
            case .unknown(let underlying) = apiError,
            (underlying is CancellationError)
                || ((underlying as? URLError)?.code == .cancelled)
        {
            return
        }
        errorMsg3 = error.localizedDescription
        showError3 = true

        if characters3.characters.isEmpty {
            loadingState = .empty
        }
    }
}

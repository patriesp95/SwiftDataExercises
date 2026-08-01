//
//  CharacterListView.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 26/07/2026.
//

import SwiftUI

struct CharacterListView3: View {
    @Environment(CharacterViewModel3.self) private var vm3

    var body: some View {
        @Bindable var vm3 = vm3

        NavigationStack {
            Group {
                switch vm3.state3 {
                case .loading3:
                    ProgressView()
                case .loaded3:
                    List {
                        ForEach(vm3.characters3.characters) { character in
                            NavigationLink {
                                CharacterDetailView3(character)
                            } label: {
                                Text(character.name)
                            }
                            .task {
                                guard
                                    character.id
                                        == vm3.characters3.characters.last?.id,
                                    vm3.hasMorePages,
                                    !vm3.isLoadingNextPage,
                                    !vm3.isLoadingInitialPage
                                else { return }
                                vm3.isLoadingNextPage = true
                                await vm3.getCharacters3()
                                vm3.isLoadingNextPage = false
                            }
                        }
                        if vm3.isLoadingNextPage {
                            HStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        }
                    }
                case .empty3:
                    ListEmptyView3()
                }
            }
            .navigationTitle("Characters")
            .refreshable {
                guard !vm3.isLoadingInitialPage, !vm3.isLoadingNextPage else {
                    return
                }
                vm3.characters3.characters = []
                vm3.hasMorePages = true
                vm3.showError3 = false
                vm3.errorMsg3 = ""
                vm3.isLoadingInitialPage = true
                await vm3.getCharacters3()
                vm3.isLoadingInitialPage = false
            }
            .alert("Error", isPresented: $vm3.showError3) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(vm3.errorMsg3)
            }
        }
        .task(priority: .high) {
            guard vm3.characters3.characters.isEmpty,
                !vm3.isLoadingInitialPage,
                !vm3.isLoadingNextPage
            else { return }
            vm3.isLoadingInitialPage = true
            await vm3.getCharacters3()
            vm3.isLoadingInitialPage = false
        }
    }
}

#Preview {
    CharacterListView3()
        .environment(
            CharacterViewModel3(
                loadAndSortCharactersUseCase: LoadAndSortCharactersUseCase3(
                    repository: CharacterRepository3(
                        remoteService: RemoteCharacterService3(
                            session3: .shared
                        ),
                        localService: BundleCharacterService3(),
                        characterDataSource: .remote
                    )
                )
            )
        )
}

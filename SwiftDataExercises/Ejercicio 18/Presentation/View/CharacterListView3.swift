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
                switch vm3.loadingState {
                case .loading, .idle:
                    ProgressView()
                case .loaded(let characters):
                    List {
                        ForEach(characters) { character in
                            NavigationLink {
                                CharacterDetailView3(character)
                            } label: {
                                Text(character.name)
                            }
                            .task {
                                guard
                                    character.id
                                        == vm3.characters3.characters.last?.id
                                else { return }
                                await vm3.loadNextPage()
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
                case .empty:
                    ListEmptyView3()
                case .error(let error):
                    Text(error)
                }
            }
            .navigationTitle("Characters")
            .refreshable {
                await vm3.loadInitial()
            }
            .alert("Error", isPresented: $vm3.showError3) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(vm3.errorMsg3)
            }
        }
        .task(priority: .high) {
            guard vm3.characters3.characters.isEmpty else { return }
            await vm3.loadInitial()
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
                            session3: URLSession.shared
                        ),
                        localService: BundleCharacterService3(),
                        characterDataSource: .remote
                    )
                )
            )
        )
}

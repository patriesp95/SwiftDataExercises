//
//  CharacterListView.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 26/07/2026.
//

import SwiftUI

struct CharacterListView2: View {
    @Environment(CharacterViewModel2.self) private var vm2

    var body: some View {
        @Bindable var vm2 = vm2

        NavigationStack {
            Group {
                switch vm2.state2 {
                case .loading2:
                    ProgressView()
                case .loaded2:
                    List {
                        ForEach(vm2.characters2.characters) { character in
                            NavigationLink {
                                CharacterDetailView2(character)
                            } label: {
                                Text(character.name)
                            }
                            .task {
                                guard character.id == vm2.characters2.characters.last?.id,
                                      vm2.hasMorePages,
                                      !vm2.isLoadingNextPage,
                                      !vm2.isLoadingInitialPage else { return }
                                vm2.isLoadingNextPage = true
                                await vm2.getCharacters2()
                                vm2.isLoadingNextPage = false
                            }
                        }
                        if vm2.isLoadingNextPage {
                            HStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        }
                    }
                case .empty2:
                    ListEmptyView2()
                }
            }
            .navigationTitle("Characters")
            .refreshable {
                guard !vm2.isLoadingInitialPage, !vm2.isLoadingNextPage else { return }
                vm2.characters2.characters = []
                vm2.hasMorePages = true
                vm2.showError2 = false
                vm2.errorMsg2 = ""
                vm2.isLoadingInitialPage = true
                await vm2.getCharacters2()
                vm2.isLoadingInitialPage = false
            }
            .alert("Error", isPresented: $vm2.showError2) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(vm2.errorMsg2)
            }
        }
        .task(priority: .high) {
            guard vm2.characters2.characters.isEmpty,
                  !vm2.isLoadingInitialPage,
                  !vm2.isLoadingNextPage else { return }
            vm2.isLoadingInitialPage = true
            await vm2.getCharacters2()
            vm2.isLoadingInitialPage = false
        }
    }
}

#Preview {
    CharacterListView2()
        .environment(
            CharacterViewModel2(
                loadAndSortCharactersUseCase: LoadAndSortCharactersUseCase(
                    repository: CharacterRepository2(
                        service2: RemoteCharacterService2(session2: .shared)
                    )
                )
            )
        )
}

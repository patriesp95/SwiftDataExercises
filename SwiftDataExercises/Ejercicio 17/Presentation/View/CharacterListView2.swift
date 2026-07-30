//
//  CharacterListView.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 26/07/2026.
//

import SwiftUI

struct CharacterListView2: View {
    @Environment(CharacterViewModel2.self) private var vm2
    @State private var showAlert2 = false
    
    var body: some View {
        VStack(alignment: .leading){
            switch vm2.state2 {
            case .loading2:
                ProgressView()
            case .loaded2:
                NavigationStack {
                    List {
                        ForEach(vm2.characters2.characters) { character in
                            NavigationLink {
                                CharacterDetailView2(character)
                            } label: {
                                Text(character.name)
                            }
                            .task {
                                if character.id == vm2.characters2.characters.last?.id,
                                   vm2.hasMorePages,
                                   !vm2.isLoadingNextPage {
                                    vm2.isLoadingInitialPage = false
                                    vm2.isLoadingNextPage = true
                                    await vm2.getCharacters2()
                                    vm2.isLoadingNextPage = false
                                }
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
                    .navigationTitle("Characters")
                }
            case .empty2:
                ListEmptyView()
            }
        }
        .task(priority: .high) {
            vm2.isLoadingInitialPage = true
            await vm2.getCharacters2()
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

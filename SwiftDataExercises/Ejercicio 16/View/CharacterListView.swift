//
//  CharacterListView.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 26/07/2026.
//

import SwiftUI

struct CharacterListView: View {
    @Environment(CharacterViewModel.self) private var vm
    @State private var showAlert = false
    
    var body: some View {
        VStack(alignment: .leading){
            switch vm.state {
            case .loading:
                ProgressView()
            case .loaded:
                NavigationStack {
                    List(vm.characters) { character in
                        NavigationLink {
                             CharacterDetailView(character)
                        } label: {
                            Text(character.name)
                        }

                    }
                    .navigationTitle("Characters")
                }
            case .empty:
                ListEmptyView()
            }
        }
        .task(priority: .high) {
            await vm.getCharacters()
        }
    }
}

#Preview {
    CharacterListView()
        .environment(
            CharacterViewModel(
                repository: CharacterRepository(
                    service: RemoteCharacterService(session: .shared)
                )
            )
        )
}

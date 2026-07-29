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
                    List(vm2.characters2.characters) { character in
                        NavigationLink {
                             CharacterDetailView2(character)
                        } label: {
                            Text(character.name)
                        }

                    }
                    .navigationTitle("Characters")
                }
            case .empty2:
                ListEmptyView()
            }
        }
        .task(priority: .high) {
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
                        service2: BundleCharacterService2()
                    )
                )
            )
        )
}

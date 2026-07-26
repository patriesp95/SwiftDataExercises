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
        VStack {
            switch vm.state {
            case .loading:
                ProgressView()
            case .loaded:
                List(vm.characters) { character in
                    Text(character.name)
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

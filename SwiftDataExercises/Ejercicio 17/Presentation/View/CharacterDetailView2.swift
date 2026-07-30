//
//  CharacterDetailView.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 27/07/2026.
//

import SwiftUI

struct CharacterDetailView2: View {
    let character2: Character2

    init(_ character2: Character2) {
        self.character2 = character2
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let imageURL = character2.imageURL {
                AsyncImage(url: imageURL) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
            }
            Text(character2.name).font(.title)
            Text("Status: \(character2.status)")
            Text("Species: \(character2.species)")
            Text("Gender: \(character2.gender)")
            Spacer()
        }
        .padding()
        .navigationTitle(character2.name)
    }
}

#Preview {
    CharacterDetailView2(.test2)
}

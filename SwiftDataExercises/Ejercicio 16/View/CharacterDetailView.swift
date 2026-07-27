//
//  CharacterDetailView.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 27/07/2026.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character

    init(_ character: Character) {
        self.character = character
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let imageURL = character.imageURL {
                AsyncImage(url: imageURL) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
            }
            Text(character.name).font(.title)
            Text("Status: \(character.status)")
            Text("Species: \(character.species)")
            Text("Gender: \(character.gender)")
            Spacer()
        }
        .padding()
        .navigationTitle(character.name)
    }
}

#Preview {
    CharacterDetailView(.test)
}

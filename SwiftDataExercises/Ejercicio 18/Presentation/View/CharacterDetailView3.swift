//
//  CharacterDetailView.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 27/07/2026.
//

import SwiftUI

struct CharacterDetailView3: View {
    let character3: Character3

    init(_ character3: Character3) {
        self.character3 = character3
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let imageURL = character3.imageURL {
                AsyncImage(url: imageURL) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
            }
            Text(character3.name).font(.title)
            Text("Status: \(character3.status)")
            Text("Species: \(character3.species)")
            Text("Gender: \(character3.gender)")
            Spacer()
        }
        .padding()
        .navigationTitle(character3.name)
    }
}

#Preview {
    CharacterDetailView3(.test3)
}

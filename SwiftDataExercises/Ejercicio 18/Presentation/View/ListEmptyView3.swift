//
//  ListEmptyView.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 26/07/2026.
//


import SwiftUI

struct ListEmptyView3: View {
    var body: some View {
        ContentUnavailableView("No character data",
                               systemImage: "person",
                               description: Text("There's no character data yet.\nTry to refresh the data or contact support."))
    }
}

#Preview {
    ListEmptyView3()
}

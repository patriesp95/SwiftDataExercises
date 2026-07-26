//
//  SwiftDataExercisesApp.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 24/07/2026.
//

import SwiftUI

@main
struct SwiftDataExercisesApp: App {
    @State private var vm = CharacterViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(vm)
        }
    }
}

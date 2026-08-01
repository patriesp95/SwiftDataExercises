//
//  LoadingState.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 01/08/2026.
//

import Foundation

enum LoadingState<Value: Decodable> {
    case idle
    case loading
    case empty
    case error(String)
    case loaded(Value)
}

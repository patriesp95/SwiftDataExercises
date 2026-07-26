//
//  APIError.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

enum APIError: LocalizedError {
    case invalidResponse
    case httpError(Int)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            "URLSession did not return a HTTPURLResponse"
        case .httpError(let code):
            "HTTP status error code: \(code)"
        }
            
    }
}

//
//  APIError.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

enum APIError: LocalizedError {
    case general(Error)
    case invalidResponse
    case json(Error)
    case httpError(Int)
    
    var errorDescription: String? {
        switch self {
        case .general(let error):
            error.localizedDescription
        case .invalidResponse:
            "URLSession did not return a HTTPURLResponse"
        case .json(let error):
            "JSON error: \(error)"
        case .httpError(let code):
            "HTTP status error code: \(code)"
        }
            
    }
}

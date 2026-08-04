//
//  StorageError.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 04/08/2026.
//

import Foundation

enum StorageError: Error, LocalizedError {
    case fileNotFound
    case fileReadFailed
    case corruptedJson
    case unknown(Error)
    
    var debugMessage: String {
        switch self {
            case .fileNotFound:
                return "Error 404 file not found"
            case .fileReadFailed:
                return "There's been an error trying to read the provided file"
            case .corruptedJson:
                return "JSON file appears to be corrupted"
            case .unknown(let error):
            return "Unknown error: \(error.localizedDescription)"
        }
    }
}

enum StorageErrorMapper {
    static func map(_ error: Error) -> StorageError {
        if let storageError = error as? StorageError {
            return storageError
        }
        
        return .unknown(error)
    }
}

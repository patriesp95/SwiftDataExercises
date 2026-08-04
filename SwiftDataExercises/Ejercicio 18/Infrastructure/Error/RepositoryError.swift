//
//  RepositoryError.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 04/08/2026.
//

import Foundation

enum RepositoryError: Error, LocalizedError {
    case remote(NetworkError)
    case local(StorageError)
    case noDataAvailable
    case unknown(Error)
    case fallbackFailed(
        remote: NetworkError,
        local: StorageError
    )

    var debugMessage: String {
        switch self {
            case .remote(let error):
                return
                    "A network error occurred. Please try again. \(error.localizedDescription)"
            case .local(let error):
                return
                    "An storage error occurred. Please try again. \(error.localizedDescription)"
            case .noDataAvailable:
                return "No data found"
            case .unknown(let error):
                return "Unknown error: \(error.localizedDescription)"
            case .fallbackFailed(remote: let remoteError, local: let localError):
                return
                    """
                    FallBack Failed remotely due to: \(remoteError.localizedDescription) and locally due to: \(localError.localizedDescription)
                    """
        }
    }
    
}

enum RepositoryErrorMapper {
    static func map(_ error: Error) -> RepositoryError {
        if let repositoryError = error as? RepositoryError {
            return repositoryError
        }
        return .unknown(error)
    }
}

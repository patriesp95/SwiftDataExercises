//
//  URLSession+Helpers.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

protocol URLSessionProtocol {
    func getData3(for request: URLRequest) async throws(NetworkError) -> (
        data: Data, response: URLResponse)
}


extension URLSession: URLSessionProtocol {
    func getData3(for request: URLRequest) async throws(NetworkError) -> (data: Data, response: URLResponse) {
        do {
            return try await data(for: request)
        } catch {
            throw .unknown(error)
        }
    }
}


#if DEBUG
    extension URLSession {
       
    }
#endif

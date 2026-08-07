//
//  URLSession+Helpers.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

protocol URLSessionProtocol {
    func getData3(for request: URLRequest) async throws(NetworkError) -> (
        data: Data, response: HTTPURLResponse)
}


extension URLSession: URLSessionProtocol {
    func getData3(for request: URLRequest) async throws(NetworkError) -> (data: Data, response: HTTPURLResponse) {
        do {
            let (data, response) = try await data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            return (data, httpResponse)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw .unknown(error)
        }
    }
}


#if DEBUG
    extension URLSession {
       
    }
#endif

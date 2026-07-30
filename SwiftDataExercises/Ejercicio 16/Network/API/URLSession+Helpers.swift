//
//  URLSession+Helpers.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

extension URLSession {
    func getData(for request: URLRequest) async throws(APIError) -> (data: Data, response: HTTPURLResponse) {
        do {
            let (data, response) = try await self.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            return (data, httpResponse)
        } catch {
            throw .general(error)
        }
    }
}

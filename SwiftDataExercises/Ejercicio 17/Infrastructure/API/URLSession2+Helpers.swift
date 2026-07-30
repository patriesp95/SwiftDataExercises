//
//  URLSession+Helpers.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

extension URLSession {
    func getData2(for request: URLRequest) async throws(APIError2) -> (data: Data, response: HTTPURLResponse) {
        do {
            let (data, response) = try await self.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError2.invalidResponse
            }
            return (data, httpResponse)
        } catch {
            print(error)
            throw .general(error)
        }
    }
}

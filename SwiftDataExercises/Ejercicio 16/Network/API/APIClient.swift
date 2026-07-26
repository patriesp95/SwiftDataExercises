//
//  APIClient.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

protocol APIClient {
    var session: URLSession { get }
}

extension APIClient {
    func request<T>(type: T.Type, _ request: URLRequest) async throws -> T where T: Decodable {
        let (data, response) = try await session.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard 200..<300 ~= response.statusCode else {
            throw APIError.httpError(response.statusCode)
        }

        return try JSONDecoder().decode(type, from: data)
    }

}

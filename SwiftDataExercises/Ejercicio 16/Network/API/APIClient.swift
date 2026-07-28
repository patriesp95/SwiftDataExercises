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
    var decoder: JSONDecoder {
        JSONDecoder()
    }
    
    func request<T>(type: T.Type, _ request: URLRequest) async throws -> T where T: Decodable {
        let (data, response) = try await session.getData(for: request)

        guard 200..<300 ~= response.statusCode else {
            throw APIError.httpError(response.statusCode)
        }

        return try decoder.decode(type, from: data)
    }
}

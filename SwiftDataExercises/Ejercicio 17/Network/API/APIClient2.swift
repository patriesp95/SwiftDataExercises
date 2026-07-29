//
//  APIClient.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

protocol APIClient2 {
    var session2: URLSession { get }
}

extension APIClient2 {
    var decoder: JSONDecoder {
        JSONDecoder()
    }
    
    func request2<T>(type: T.Type, _ request: URLRequest) async throws -> T where T: Decodable {
        let (data, response) = try await session2.getData(for: request)

        guard 200..<300 ~= response.statusCode else {
            throw APIError.httpError(response.statusCode)
        }

        return try decoder.decode(type, from: data)
    }
}

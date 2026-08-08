//
//  APIClient.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

protocol APIClient3 {
    var session3: URLSessionProtocol { get }
}

extension APIClient3 {
    var decoder: JSONDecoder {
        JSONDecoder()
    }
    
    func request3<T>(type: T.Type, _ request: URLRequest) async throws -> T where T: Decodable {
        let (data, response) = try await session3.getData3(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.httpStatus(code: httpResponse.statusCode)
        }

        do {
            return try decoder.decode(type, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
}

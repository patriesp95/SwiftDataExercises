//
//  URLRequest+Helpers.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

enum HTTPMethod3: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

extension URLRequest {
    static func make3(url: URL, httpMethod: HTTPMethod3 = .get) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.timeoutInterval = 60
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return request
    }
}

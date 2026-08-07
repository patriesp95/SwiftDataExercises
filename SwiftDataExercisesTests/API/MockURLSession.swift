//
//  MockURLSession.swift
//  SwiftDataExercisesTests
//
//  Created by Patricia M Espert on 07/08/2026.
//

import Foundation
import Testing
@testable import SwiftDataExercises

struct MockURLSession: URLSessionProtocol {

    var stubData: Data = Data()
    var stubResponse: HTTPURLResponse = HTTPURLResponse()
    var stubError: NetworkError?

    func getData3(for request: URLRequest) async throws(NetworkError) -> (
        data: Data, response: HTTPURLResponse
    ) {
        if let stubError {
            throw stubError
        }
        return (stubData, stubResponse)
    }
}



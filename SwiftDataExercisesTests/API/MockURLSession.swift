//
//  MockURLSession.swift
//  SwiftDataExercisesTests
//
//  Created by Patricia M Espert on 07/08/2026.
//

import Foundation
import Testing
@testable import SwiftDataExercises

final class MockURLSession: URLSessionProtocol {

    var stubData: Data
    var stubResponse: HTTPURLResponse
    var stubError: NetworkError?
    private(set) var receivedRequest: URLRequest?

    init(
        stubData: Data = Data(),
        stubResponse: HTTPURLResponse = HTTPURLResponse(),
        stubError: NetworkError? = nil
    ) {
        self.stubData = stubData
        self.stubResponse = stubResponse
        self.stubError = stubError
    }

    func getData3(for request: URLRequest) async throws(NetworkError) -> (
        data: Data, response: HTTPURLResponse
    ) {
        receivedRequest = request
        if let stubError {
            throw stubError
        }
        return (stubData, stubResponse)
    }
}



//
//  APIClientTests.swift
//  SwiftDataExercisesTests
//
//  Created by Patricia M Espert on 07/08/2026.
//

import Foundation
import Testing

@testable import SwiftDataExercises

struct APIClientTests {

    struct TestAPIClient: APIClient3 {
        let session3: URLSessionProtocol
    }

    private let myRequest = URLRequest.get3(
        url: CharacterEndpoint3.getCharacters3Paginated(page: 1)
    )
    
    //MARK: 1. Respuesta 200 OK

    @Test("Response 200 OK decodes the payload")
    func response200() async throws {
        let json = mockedJson.data(using: .utf8)!

        let session = MockURLSession(
            stubData: json,
            stubResponse: HTTPURLResponse(
                url: myRequest.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
        )
        let sut = TestAPIClient(session3: session)

        let characterResponse = try await sut.request3(
            type: CharacterResponseDTO3.self,
            myRequest
        )

        #expect(
            characterResponse.results
            == CharacterResponseDTO3.characterResponseDTOtest3.results
        )
        #expect(!characterResponse.results.isEmpty)
    }
    
    //MARK: 2. Error 404
    
    @Test("Error 404 is thrown")
    func responseError404() async throws {
        let json = mockedJson.data(using: .utf8)!

        let session = MockURLSession(
            stubData: json,
            stubResponse: HTTPURLResponse(
                url: myRequest.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!,
            stubError: NetworkError.httpStatus(code: 404)
        )
        let sut = TestAPIClient(session3: session)

        //When / Then
        do {
            _ = try await sut.request3(
                type: CharacterResponseDTO3.self,
                myRequest
            )
        } catch {
            switch error {
            case NetworkError.httpStatus(let code):
                #expect(code == 404)
                #expect(error.localizedDescription == "The requested resource could not be found.")
            default:
                Issue.record("NetworkError.httpStatus(code: 404), got: \(error)")
            }
        }
    }
    
    //MARK: 3. Error 500
    
    @Test("Error 500 is thrown")
    func responseError500() async throws {
        let json = mockedJson.data(using: .utf8)!

        let session = MockURLSession(
            stubData: json,
            stubResponse: HTTPURLResponse(
                url: myRequest.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!,
            stubError: NetworkError.httpStatus(code: 500)
        )
        let sut = TestAPIClient(session3: session)

        //When / Then
        do {
            _ = try await sut.request3(
                type: CharacterResponseDTO3.self,
                myRequest
            )
        } catch {
            switch error {
            case NetworkError.httpStatus(let code):
                #expect(code == 500)
                #expect(error.localizedDescription == "The server is having trouble right now. Please try again later.")
            default:
                Issue.record("NetworkError.httpStatus(code: 500), got: \(error)")
            }
        }
    }
    
    //MARK: 4. JSON corrupto
    
    @Test("JSON is corrupted")
    func jsonIsCorrupted() async throws {
        let json = mockedJson_corrupted.data(using: .utf8)!

        let session = MockURLSession(
            stubData: json,
            stubResponse: HTTPURLResponse(
                url: myRequest.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!,
            stubError: NetworkError.decodingFailed(
                DecodingError.dataCorrupted(
                    .init(codingPath: [], debugDescription: "corrupted")
                )
            )
        )
        let sut = TestAPIClient(session3: session)

        //When / Then
        do {
            _ = try await sut.request3(
                type: CharacterResponseDTO3.self,
                myRequest
            )
        } catch {
            switch error {
            case NetworkError.decodingFailed(let error):
                #expect(error.localizedDescription == "The data couldn’t be read because it isn’t in the correct format.")
            default:
                Issue.record("NetworkError.decodingFailed, got: \(error)")
            }
        }
    }
}

extension APIClientTests {
    fileprivate var mockedJson: String {
        return """
            {
                "info": { "count": 826, "pages": 42, "next": "https://rickandmortyapi.com/api/character/?page=2", "prev": null },
                "results": [
            {
                  "id": 1,
                  "name": "Rick Sanchez",
                  "status": "Alive",
                  "species": "Human",
                  "type": "",
                  "gender": "Male",
                  "origin": {
                    "name": "Earth",
                    "url": "https://rickandmortyapi.com/api/location/1"
                  },
                  "location": {
                    "name": "Earth",
                    "url": "https://rickandmortyapi.com/api/location/20"
                  },
                  "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                  "episode": [
                    "https://rickandmortyapi.com/api/episode/1",
                    "https://rickandmortyapi.com/api/episode/2"
                  ],
                  "url": "https://rickandmortyapi.com/api/character/1",
                  "created": "2017-11-04T18:48:46.250Z"
                }
            ]
            }
            """
    }
    
    fileprivate var mockedJson_corrupted: String {
        return """
            {
                "info": { "count": 826, "pages": 42, "next": "https://rickandmortyapi.com/api/character/?page=2", "prev": null },
                "results": [
            {
                  "id": "1",
                  "name": "Rick Sanchez",
                  "status": "Alive",
                  "species": "Human",
                  "type": "",
                  "gender": "Male",
                  "origin": {
                    "name": "Earth",
                    "url": "https://rickandmortyapi.com/api/location/1"
                  },
                  "location": {
                    "name": "Earth",
                    "url": "https://rickandmortyapi.com/api/location/20"
                  },
                  "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                  "episode": [
                    "https://rickandmortyapi.com/api/episode/1",
                    "https://rickandmortyapi.com/api/episode/2"
                  ],
                  "url": "https://rickandmortyapi.com/api/character/1",
                  "created": "2017-11-04T18:48:46.250Z"
                }
            ]
            }
            """
    }
}

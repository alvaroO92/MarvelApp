//
//  CharactersNetworkClientTests.swift
//  MarvelAppTests
//
//  Created by Alvaro Orti Moreno on 2/7/22.
//

import XCTest
@testable import MarvelApp

final class CharactersNetworkClientTests: XCTestCase {

    var mockData: CharactersNetworkClientMockData!

    override func setUp() {
        super.setUp()
        mockData = CharactersNetworkClientMockData()
    }

    override func tearDown() {
        super.tearDown()
        mockData = nil
    }

    func test_when_get_characters_page0_response_general_network_error() {

        // Given
        let errorToTest = NetworkError.general(NSError(domain: "", code: -999, userInfo: nil))
        let sut = makeSut(jsonFile: mockData.jsonFile,
                          networkError: errorToTest)
        let expectation = XCTestExpectation(description: "test_when_getCharacters_page0_responseGeneralNetworkError")

        // When
        sut.getCharacters(page: 0) { response in
            switch response {
            case .success:
                XCTFail("Success response")
                expectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(error, .general(NSError(domain: "", code: -999, userInfo: nil)))
                expectation.fulfill()
            }
        }
        // Then
        wait(for: [expectation], timeout: 1.0)
    }

    func test_when_get_characters_page0_response_json_network_error() {

        // Given
        let errorToTest = NetworkError.json(NSError(domain: "", code: -999, userInfo: nil))
        let sut = makeSut(jsonFile: mockData.jsonFile,
                          networkError: errorToTest)
        let expectation = XCTestExpectation(description: "test_when_get_characters_page0_response_json_network_error")

        // When
        sut.getCharacters(page: 0) { response in
            switch response {
            case .success:
                XCTFail("Success response")
                expectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(error, .json(NSError(domain: "", code: -999, userInfo: nil)))
                XCTAssertEqual(error.description(), "alertDefaultError_message".localized)
                expectation.fulfill()
            }
        }
        // Then
        wait(for: [expectation], timeout: 1.0)
    }

    func test_when_getCharacters_page0_response_status_network_error() {

        // Given
        let errorToTest = NetworkError.status(999)
        let sut = makeSut(jsonFile: mockData.jsonFile,
                          networkError: errorToTest)
        let expectation = XCTestExpectation(description: "test_when_getCharacters_page0_responseStatusNetworkError")

        // When
        sut.getCharacters(page: 0) { response in
            switch response {
            case .success:
                XCTFail("Success response")
                expectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(error, .status(404))
                XCTAssertEqual(error.description(), "alertDefaultError_message".localized)
                expectation.fulfill()
            }
        }
        // Then
        wait(for: [expectation], timeout: 1.0)
    }

    func test_when_getCharacters_page0_response_no_HTTP_network_error() {

        // Given
        let errorToTest = NetworkError.noHTTP
        let sut = makeSut(jsonFile: mockData.jsonFile,
                          networkError: errorToTest)
        let expectation = XCTestExpectation(description: "test_when_getCharacters_page0_response_no_HTTP_network_error")

        // When
        sut.getCharacters(page: 0) { response in
            switch response {
            case .success:
                XCTFail("Success response")
                expectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(error, .noHTTP)
                XCTAssertEqual(error.description(), "alertDefaultError_message".localized)
                expectation.fulfill()
            }
        }
        // Then
        wait(for: [expectation], timeout: 1.0)
    }

    private func makeSut(jsonFile: String, networkError: NetworkError) -> CharactersNetworkClientStub {
        return CharactersNetworkClientStub(jsonName: jsonFile, networkError: networkError)
    }
}

struct CharactersNetworkClientMockData {
    var jsonFile = "MarvelCharactersMockResponse"
}

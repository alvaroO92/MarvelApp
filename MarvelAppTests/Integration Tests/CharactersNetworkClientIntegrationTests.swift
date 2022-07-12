//
//  CharactersNetworkClientIntegrationTests.swift
//  MarvelAppTests
//
//  Created by Alvaro Orti Moreno on 3/7/22.
//

import XCTest
@testable import MarvelApp

final class CharactersNetworkClientIntegrationTests: XCTestCase {

    func test_when_call_validUrl_Page0_success_response() {
        // Given
        let expectation = XCTestExpectation(description: "test_when_call_validUrl_Page0_success_response")

        // When
        let sut = makeSut(baseURL: Constants.baseUrl)

        sut.getCharacters(page: 0) { response in
            switch response {
            case .success(let data):
                XCTAssertNotNil(data)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("\(error.description())")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 3.1)
    }

    func test_when_call_validUrl_Page999_error_response() {
        // Given
        let expectation = XCTestExpectation(description: "test_when_call_validUrl_Page999_error_response")

        // When
        let sut = makeSut(baseURL: Constants.baseUrl)

        sut.getCharacters(page: -999) { response in
            switch response {
            case .success(let data):
                XCTFail("\(data.count)")
                expectation.fulfill()
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 3.2)
    }

    func test_when_call_invalidUrl_Page0_error_response() {
        // Given
        let expectation = XCTestExpectation(description: "test_when_call_invalidUrl_Page0_error_response")

        // When
        let sut = makeSut(baseURL: "")

        sut.getCharacters(page: 0) { response in
            switch response {
            case .success(let data):
                XCTFail("\(data.count)")
                expectation.fulfill()
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 3.3)
    }

    func makeSut(baseURL: String) -> CharacterListNetworkClient {
        CharacterListNetworkClient(baseURL: baseURL)
    }
}

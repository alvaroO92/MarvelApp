//
//  CharacterListRepositoryTests.swift
//  MarvelAppTests
//
//  Created by Alvaro Orti Moreno on 3/7/22.
//

import XCTest
import RealmSwift
@testable import MarvelApp

final class CharacterListRepositoryTests: XCTestCase {

    func test_when_get_characters_page0_response_success() {
        // Given
        let sut = makeSut()
        let expectation = XCTestExpectation(description: "test_when_getCharacters_page0_responseSuccess")

        // When
        sut.getCharacters(page: 0) { response in
            switch response {
            case .success(let data):
                XCTAssertEqual(data.response.data?.results.count, 100)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.description())
                expectation.fulfill()
            }
        }
        // Then
        wait(for: [expectation], timeout: 3.0)
    }

    func test_when_receive_offline_error_set_local_data() {

        // Given
        let sut = makeSut(forceError: .networkConnection)
        let expectation = XCTestExpectation(description: "test_when_receive_offline_error_set_local_data")

        // When
        sut.getCharacters(page: 0) { response in
            switch response {
            case .success(let data):
                XCTAssertEqual(data.response.data?.results.count, 100)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.description())
                expectation.fulfill()
            }
        }
        // Then
        wait(for: [expectation], timeout: 3.2)
    }

    func makeSut(forceError: NetworkError? = nil) -> CharacterListRepository {
        let mockData = CharactersNetworkClientMockData()
        let characterNetworkClient = CharactersNetworkClientStub(jsonName: mockData.jsonFile, networkError: forceError)
        let localDatabase = LocalDatabaseFake()

        return CharacterListRepository(
            networkClient: characterNetworkClient,
            localDatabase: localDatabase
        )
    }
}

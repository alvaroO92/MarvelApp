//
//  CharacterListInteractorTests.swift
//  MarvelAppTests
//
//  Created by Alvaro Orti Moreno on 3/7/22.
//

import XCTest
@testable import MarvelApp

class CharacterListInteractorTests: XCTestCase {

    func test_when_fetch_characterList_success_response() {

        // Given
        let sut = makeSut()
        let characterToTest = Character(id: 0,
                                        name: "test",
                                        description: "test",
                                        thumbnail: nil,
                                        resourceURI: nil)
        let expectation = XCTestExpectation(description: "test_when_fetch_characterList_success_response")

        // When
        sut.fetchCharacterList(refresh: false) { response in
            switch response {
            case .success(let data):
                XCTAssertNotNil(data)
                XCTAssertEqual(data.first, characterToTest)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.description())
                expectation.fulfill()
            }
        }
        // Then
        wait(for: [expectation], timeout: 1.0)
    }

    func test_when_refresh_characterList_reload_data() {

        // Given
        let sut = makeSut()
        let characterToTest = Character(id: 0,
                                        name: "refresher Name",
                                        description: "refresher Desc",
                                        thumbnail: nil,
                                        resourceURI: nil)
        let expectation = XCTestExpectation(description: "test_when_refresh_characterList_reload_data")

        // When
        sut.fetchCharacterList(refresh: true) { response in
            switch response {
            case .success(let data):
                XCTAssertNotNil(data)
                XCTAssertEqual(data.first, characterToTest)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.description())
                expectation.fulfill()
            }
        }
        // Then
        wait(for: [expectation], timeout: 1.0)
    }

    func test_when_filter_characterList_valid_text_return_data() {

        // Given
        let sut = makeSut()
        let textToTest = "test"
        let expectation = XCTestExpectation(description: "test_when_filter_characterList_valid_text_return_data")

        // When
        sut.fetchCharacterList(refresh: false) { response in
            switch response {
            case .success:
                expectation.fulfill()
            case .failure:
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
        sut.isSearching = true
        let filtered = sut.filterCharacter(with: textToTest)
        // Then
        XCTAssertTrue(filtered.count > 0)
    }

    func test_when_filter_characterList_empty_text_return_error() {

        // Given
        let sut = makeSut()
        let textToTest = ""

        // When
        let filtered = sut.filterCharacter(with: textToTest)
        // Then
        XCTAssertTrue(filtered.count == 0)
    }


    func makeSut(forceError: NetworkError? = nil, offline: Bool? = false) -> CharacterListInteractor {
        let networkClient = CharactersNetworkClientStub(jsonName: "MarvelCharactersMockResponse", networkError: forceError)
        let localDatabase = LocalDatabaseFake()
        let repository = CharacterListRepositoryStub(networkCient: networkClient, localDatabase: localDatabase, offlineMode: offline ?? false)
        return CharacterListInteractor(repository: repository)
    }
}

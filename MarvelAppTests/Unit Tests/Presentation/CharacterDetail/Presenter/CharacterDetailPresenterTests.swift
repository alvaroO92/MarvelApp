//
//  CharacterDetailPresenterTests.swift
//  MarvelAppTests
//
//  Created by Alvaro Orti Moreno on 3/7/22.
//

import XCTest
@testable import MarvelApp

final class CharacterDetailPresenterTests: XCTestCase {

    func test_when_check_state_receive_alldata() {

        // Given
        let dataToTest = Character(
            id: 0,
            name: "test",
            description: "test",
            thumbnail: .init(url: URL(fileURLWithPath: "")),
            resourceURI: ""
        )
        let expectation = XCTestExpectation(description: "test_when_check_state_receive_alldata")

        // When
        let sut = makeSut(character: dataToTest)

        sut.viewConfig { model in
            XCTAssertEqual(model.image, nil)
            XCTAssertEqual(model.decription, "test")
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 1.0)
    }

    func makeSut(character: Character) -> CharacterDetailPresenter {
        CharacterDetailPresenter(character: character)
    }
}

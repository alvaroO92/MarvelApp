//
//  CharactersCoordinatorTests.swift
//  MarvelAppTests
//
//  Created by Alvaro Orti Moreno on 3/7/22.
//

import XCTest
@testable import MarvelApp

final class CharactersCoordinatorTests: XCTestCase {

    var sut: CharactersCoordinator!

    override func setUp() {
        super.setUp()
        sut = CharactersCoordinator(navigator: NavigationController())
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_when_start_coordinator_show_character_list() {
        // When
        sut.start()

        // Then
        XCTAssertTrue(sut.navigator.topViewController is CharacterListViewController)
    }

    func test_when_go_to_detail_change_topViewController() {

        // Given
        let characterToTest = Character(id: 0, name: "", description: "", thumbnail: nil, resourceURI: nil)

        // When
        sut.showCharacterDetail(character: characterToTest)

        // Then
        XCTAssertTrue(sut.navigator.topViewController is CharacterDetailViewController)
    }

}

//
//  CharacterListPresenterTests.swift
//  MarvelAppTests
//
//  Created by Alvaro Orti Moreno on 3/7/22.
//

import XCTest
@testable import MarvelApp

final class CharacterListPresenterTests: XCTestCase {

    func test_when_viewDidLoad_fetch_characters() {

        // Given
        let sut = makeSut(isSearching: false)
        let characterToTest = Character(id: 0, name: "test", description: "test", thumbnail: nil, resourceURI: nil)

        // When
        sut.viewDidLoad()

        // Then
        XCTAssertEqual(sut.characters.count, 1)
        XCTAssertEqual(sut.characters.first, characterToTest)
    }

    func test_when_viewDidLoad_response_error() {

        // Given
        let sut = makeSut(isSearching: false, networkError: .general(NSError(domain: "", code: -999, userInfo: nil)))

        // When
        sut.viewDidLoad()

        // Then
        XCTAssertTrue(sut.characters.count == 0)
    }

    func test_when_refreshData_reload_characters() {

        // Given
        let sut = makeSut(isSearching: false)
        let characterToTest = Character(id: 0, name: "refresher Name", description: "refresher Desc", thumbnail: nil, resourceURI: nil)

        // When
        sut.refreshData()

        // Then
        XCTAssertEqual(sut.characters.count, 1)
        XCTAssertEqual(sut.characters.first, characterToTest)
    }

    func test_when_filter_valid_data_add_filter_characters() {

        // Given
        let sut = makeSut(isSearching: true)
        let textToTest = "test"

        // When
        sut.filterData(by: textToTest)

        // Then
        XCTAssertEqual(sut.filteredCharacters.count, 1)
    }

    func test_when_viewDidLoad_numberOfSections_is_1() {

        // Given
        let sut = makeSut(isSearching: false)

        // When
        sut.viewDidLoad()

        // Then
        XCTAssertEqual(sut.numberOfSections(), 1)
    }

    func test_when_viewDidLoad_numberOfRows_in_section1_is_1() {

        // Given
        let sut = makeSut(isSearching: false)

        // When
        sut.viewDidLoad()

        // Then
        XCTAssertEqual(sut.numberOfRowsInSections(1), 1)
    }

    func test_when_viewDidLoad_cellForIndexPath_0_return_character() {

        // Given
        let sut = makeSut(isSearching: false)
        let indexPathToTest = IndexPath(row: 0, section: 0)
        let characterToTest: CharacterTableViewCell.Model = .init(name: "test", description: "test", image: nil)

        // When
        sut.viewDidLoad()
        let cell = sut.cellForRow(for: indexPathToTest)

        // Then
        switch cell {
        case .showCharacter(let data):
            XCTAssertEqual(data.name, characterToTest.name)
            XCTAssertEqual(data.description, characterToTest.description)
            XCTAssertEqual(data.image, characterToTest.image)
        case .noResults:
            XCTFail("No results")
        }
    }

    func test_when_viewDidLoad_cellForIndexPath_InvalidIndexPath_return_noResults() {

        // Given
        let sut = makeSut(isSearching: false)
        let indexPathToTest = IndexPath(row: -9, section: -9)

        // When
        let cell = sut.cellForRow(for: indexPathToTest)

        // Then
        switch cell {
        case .showCharacter:
            XCTFail("Has data")
        case .noResults(let message):
            XCTAssertTrue(message == "noResults".localized)
        }
    }

    func test_when_viewDisplay_IndexPath0_show_characters() {

        // Given
        let sut = makeSut(isSearching: false)

        // When
        sut.viewDidLoad()
        sut.willDisplay(for: IndexPath(row: 0, section: 0))

        // Then
        XCTAssertTrue(sut.characters.count > 0)
    }

    func test_when_is_select_indexPath_0_go_to_detail() {

        // Given
        let sut = makeSut(isSearching: false)
        let indexPathToTest = IndexPath(row: 0, section: 0)

        // When
        sut.viewDidLoad()
        sut.didSelect(for: indexPathToTest)

        // Then
        XCTAssertTrue((sut.coordinator as! CharactersCoordinatorSpy).showCharacterDetailCount > 0)
    }

    func makeSut(isSearching: Bool, networkError: NetworkError? = nil)  -> CharacterListPresenter {
        let interactor = CharacterListInteractorStub(
            isSearching: isSearching,
            networkError: networkError
        )
        let coordinator = CharactersCoordinatorSpy()
        let presenter = CharacterListPresenter(
            interactor: interactor,
            coordinator: coordinator
        )
        return presenter
    }
}

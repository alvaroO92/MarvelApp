//
//  CharacterListViewControllerTests.swift
//  MarvelAppTests
//
//  Created by Alvaro Orti Moreno on 3/7/22.
//

import XCTest
@testable import MarvelApp

class CharacterListViewControllerTests: XCTestCase {

    var sut: CharacterListViewController!

    override func setUp() {
        super.setUp()
        let interactor = CharacterListInteractorStub(isSearching: false, networkError: nil)
        let presenter = CharacterListPresenterStub(interactor: interactor)
       sut = CharacterListViewController(presenter: presenter)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_when_setupView_drawView() {

        // When
        sut.setupView()

        // Then
        XCTAssertEqual(sut.title, "characterList_title".localized)
        XCTAssertEqual(sut.tableView.backgroundView, nil)
        XCTAssertEqual(sut.tableView.backgroundColor, Colors.App.view02.uiColor)
        XCTAssertEqual(sut.tableView.separatorStyle, .none)
    }

    func test_showRefreshData_isRefreshing() {

        // Given
        let expectation = XCTestExpectation(description: "test_showRefreshData_isRefreshing")

        // When
        sut.showRefreshData()
        DispatchQueue.main.async() {
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 2.0)
        XCTAssertTrue(sut.refresher.isRefreshing)
    }

    func test_showHideRefreshData_isRefreshingFalse() {

        // Given
        let expectation = XCTestExpectation(description: "test_showHideRefreshData_isRefreshingFalse")

        // When
        sut.hideRefreshData()
        DispatchQueue.main.async() {
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 2.0)
        XCTAssertFalse(sut.refresher.isRefreshing)
    }

    func test_showFooter_setInTableViewFooter() {

        // Given
        let expectation = XCTestExpectation(description: "test_showFooter_setInTableViewFooter")

        // When
        sut.showFooterSpinner()
        DispatchQueue.main.async() {
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 2.0)
        XCTAssertNotNil(sut.tableView.tableFooterView)
    }

    func test_hideFooter_removeTableViewFooter() {

        // Given
        let expectation = XCTestExpectation(description: "test_hideFooter_removeTableViewFooter")

        // When
        sut.hideFooterSpinner()
        DispatchQueue.main.async() {
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 2.2)
        XCTAssertTrue(sut.tableView.tableFooterView!.isHidden)
    }
}

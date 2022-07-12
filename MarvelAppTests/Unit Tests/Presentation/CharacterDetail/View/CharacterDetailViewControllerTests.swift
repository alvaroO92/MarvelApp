//
//  CharacterDetailViewControllerTests.swift
//  MarvelAppTests
//
//  Created by Alvaro Orti Moreno on 3/7/22.
//

import XCTest
@testable import MarvelApp

class CharacterDetailViewControllerTests: XCTestCase {

    var sut: CharacterDetailViewController!

    override func setUp() {
        super.setUp()
        let presenter = CharacterDetailPresenterStub(characters: [])
        sut = CharacterDetailViewController(presenter: presenter)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_when_setupView_drawView() {

        // When
        sut.setupView()

        // Then
        XCTAssertEqual(sut.title, "characterDetail_title".localized)
        XCTAssertEqual(sut.view.backgroundColor, Colors.App.view02.uiColor)
    }
}

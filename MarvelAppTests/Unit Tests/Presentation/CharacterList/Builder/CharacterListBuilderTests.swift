//
//  CharacterListBuilderTests.swift
//  MarvelAppTests
//
//  Created by Alvaro Orti Moreno on 3/7/22.
//

import XCTest
@testable import MarvelApp

class CharacterListBuilderTests: XCTestCase {

    var sut: CharacterListBuilder!

    override func setUp() {
        super.setUp()
        let coordinator = CharactersCoordinatorSpy()
        sut = CharacterListBuilder(currentCoordinator: coordinator)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_when_build_return_viewController() {
        let viewController = sut.build()
        XCTAssertNotNil(viewController)
    }
}

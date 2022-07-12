//
//  CharacterDetailBuilderTests.swift
//  MarvelAppTests
//
//  Created by Alvaro Orti Moreno on 3/7/22.
//

import XCTest
@testable import MarvelApp

class CharacterDetailBuilderTests: XCTestCase {

    var sut: CharacterDetailBuilder!

    override func setUp() {
        super.setUp()
        let character = Character(id: 0, name: "", description: "", thumbnail: nil, resourceURI: nil)
        sut = CharacterDetailBuilder(character: character)
    }

    override func tearDown() {
       sut = nil
    }

    func test_when_build_return_viewController() {
        let viewController = sut.build()
        XCTAssertNotNil(viewController)
    }
}

//
//  SpaceViewTests.swift
//  MarvelAppTests
//
//  Created by Alvaro Orti Moreno on 3/7/22.
//

import XCTest
@testable import MarvelApp

class SpaceViewTests: XCTestCase {

    var sut: SpaceView!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
       super.tearDown()
        sut = nil
    }

    func test_when_setup_10px_vertical_space_update_ui() {

        // Given
        let sut = SpaceView(10, in: .vertical)
        sut.setNeedsLayout()

        // Then
        XCTAssertEqual(sut.space, 10)
        XCTAssertEqual(sut.axis, .vertical)
    }

    func test_when_setup_10px_horizontal_space_update_ui() {

        // Given
        let sut = SpaceView(10, in: .horizontal)
        sut.setNeedsLayout()

        // Then
        XCTAssertEqual(sut.space, 10)
        XCTAssertEqual(sut.axis, .horizontal)
    }

    func test_init_with_coder_for_xib_init() {
        // Given
        var sut = SpaceView(0, in: .vertical)
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: sut, requiringSecureCoding: false) else { return }
        guard let coder = try? NSKeyedUnarchiver(forReadingFrom: data) else { return }

        // When
        sut = SpaceView(coder: coder)!

        // Then
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.space, .zero)
        XCTAssertEqual(sut.axis, .vertical)
    }
}

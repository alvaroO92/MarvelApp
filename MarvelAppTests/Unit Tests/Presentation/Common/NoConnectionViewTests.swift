//
//  NoConnectionViewTests.swift
//  MarvelAppTests
//
//  Created by Alvaro Orti Moreno on 3/7/22.
//

import XCTest
@testable import MarvelApp

final class NoConnectionViewTests: XCTestCase {

    var sut: NoConnectionView!

    override func setUp() {
        super.setUp()
        sut = NoConnectionView(frame: .zero)
    }

    override func tearDown() {
       super.tearDown()
        sut = nil
    }

    func test_when_did_tap_closure_act() {

        // Given
        let expectation = XCTestExpectation(description: "test_when_did_tap_closure_act")

        // When

        sut.closeButtonTapped = {
            expectation.fulfill()
        }

        sut.closeButtonTapped(sut.closeButton)

        wait(for: [expectation], timeout: 1.0)
    }

    func test_init_with_coder_for_xib_init() {

        // Given
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: sut!, requiringSecureCoding: false) else { return }
        guard let coder = try? NSKeyedUnarchiver(forReadingFrom: data) else { return }

        // When
        sut = NoConnectionView(coder: coder)

        // Then
        XCTAssertNotNil(sut)
    }
}

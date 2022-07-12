//
//  CacheImagesRepositoryTests.swift
//  MarvelAppTests
//
//  Created by Alvaro Orti Moreno on 3/7/22.
//

import XCTest
@testable import MarvelApp

class CacheImagesRepositoryTests: XCTestCase {

    func test_when_receive_validURL_responseImage() {
        // Given
        let sut = makeSut()
        let expectation = XCTestExpectation(description: "test_when_receive_validURL_responseImage")

        let urlToTest = URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg")!
        sut.load(with: urlToTest) { image in
            DispatchQueue.main.async {
                XCTAssertNotNil(image)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 0.5)
    }

    func test_when_receive_invalidURL_responseImage() {
        // Given
        let sut = makeSut()
        let expectation = XCTestExpectation(description: "test_when_receive_invalidURL_responseImage")

        let urlToTest = URL(string: "ht://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg")!
        sut.load(with: urlToTest) { image in
            DispatchQueue.main.async {
                XCTAssertNil(image)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1.5)
    }


    func makeSut() -> CacheImagesRepository {
        let cacheImages = CacheImagesFake()
        return CacheImagesRepository(cacheImages: cacheImages)
    }
}

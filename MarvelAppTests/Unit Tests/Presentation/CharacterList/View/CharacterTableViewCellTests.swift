//
//  CharacterTableViewCellTests.swift
//  MarvelAppTests
//
//  Created by Alvaro Orti Moreno on 3/7/22.
//

import XCTest
@testable import MarvelApp

final class CharacterTableViewCellTests: XCTestCase {

    var sut: CharacterTableViewCell!

    override func setUp() {
       super.setUp()
        sut = CharacterTableViewCell(style: .default, reuseIdentifier: "CharacterTableViewCell")
    }

    override func tearDown() {
      super.tearDown()
        sut = nil
    }

    func test_when_display_model_fill_items() {

        // Given
        let modelToTest = CharacterTableViewCell.Model(name: "name", description: "description", image: nil)

        // When
        sut.display(with: modelToTest)

        // Then
        XCTAssertEqual(sut.nameLabel.text, "name")
        XCTAssertEqual(sut.descriptionLabel.text, "description")
    }

    func test_when_call_layoutSubviews_round_imageView() {

        // When
        sut.layoutSubviews()

        // Then
        XCTAssertEqual(sut.characterImageView.layer.cornerRadius, 30)
    }

    func test_when_prepareForReuse_restore_data() {

        // When
        sut.prepareForReuse()

        // Then
        XCTAssertEqual(sut.nameLabel.text, "")
        XCTAssertEqual(sut.descriptionLabel.text, "")
        XCTAssertEqual(sut.characterImageView.image, nil)
    }

    func test_init_with_coder_for_xib_init() {

        // Given
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: sut!, requiringSecureCoding: false) else { return }
        guard let coder = try? NSKeyedUnarchiver(forReadingFrom: data) else { return }

        // When
        sut = CharacterTableViewCell(coder: coder)

        // Then
        XCTAssertNotNil(sut)
    }
}

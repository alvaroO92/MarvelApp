//
//  CharacterDetailPresenterStub.swift
//  MarvelAppTests
//
//  Created by Alvaro Orti Moreno on 3/7/22.
//

import UIKit
import Foundation
@testable import MarvelApp

final class CharacterDetailPresenterStub: CharacterDetailPresenterProtocol {

    let characters: [Character]

    private(set) var viewWillAppearCount: Int = 0

    init(characters: [Character]) {
        self.characters = characters
    }

    func viewWillAppear() {
        viewWillAppearCount += 1
    }

    func viewConfig(completion: @escaping (CharacterDetailViewModel) -> Void) {
        let model = CharacterDetailViewModel(image: UIImage(), description: "test")
        completion(model)
    }
}

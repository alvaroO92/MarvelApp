//
//  CharacterDetailBuilder.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 2/7/22.
//

import UIKit

final class CharacterDetailBuilder: Builder {

    let character: Character

    init(character: Character) {
        self.character = character
    }

    func build() -> UIViewController {
        let presenter = CharacterDetailPresenter(character: character)
        let viewController = CharacterDetailViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}

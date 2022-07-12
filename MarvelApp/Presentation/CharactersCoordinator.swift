//
//  CharactersCoordinator.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 1/7/22.
//

import UIKit

protocol CharactersCoordinatorProtocol {
    func showCharacterList()
    func showCharacterDetail(character: Character)
}

final class CharactersCoordinator: Coordinator {

    let navigator: UINavigationController

    init(navigator: UINavigationController) {
        self.navigator = navigator
    }

    func start() {
        showCharacterList()
    }
}

extension CharactersCoordinator: CharactersCoordinatorProtocol {
    func showCharacterList() {
        let vc = CharacterListBuilder(currentCoordinator: self).build()
        navigator.pushViewController(vc, animated: true)
    }

    func showCharacterDetail(character: Character) {
        let vc = CharacterDetailBuilder(character: character).build()
        navigator.pushViewController(vc, animated: true)
    }
}

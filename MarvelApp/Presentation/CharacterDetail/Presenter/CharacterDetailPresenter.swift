//
//  CharacterDetailPresenter.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 2/7/22.
//

import Foundation

final class CharacterDetailPresenter {
    weak var view: CharacterDetailViewControllerProtocol?

    let character: Character

    init(character: Character) {
        self.character = character
    }
}

 // MARK: - CharacterDetailPresenterProtocol
extension CharacterDetailPresenter: CharacterDetailPresenterProtocol {

    func viewWillAppear() {
        view?.setupView()
    }

    func viewConfig(completion: @escaping (CharacterDetailViewModel) -> Void) {

        character.thumbnail?.loadImage(completion: { image in
            DispatchQueue.main.async { [weak self] in
                completion(
                    .init(image: image,
                          description: self?.character.description
                         )
                )
            }
        })
    }
}

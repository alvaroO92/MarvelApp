//
//  CharacterListPresenterStub.swift
//  MarvelAppTests
//
//  Created by Alvaro Orti Moreno on 3/7/22.
//

import Foundation
@testable import MarvelApp

final class CharacterListPresenterStub: CharacterListPresenterProtocol {

    private(set) var viewWillAppearCount: Int = 0
    private(set) var willDisplayCount: Int = 0
    private(set) var didSelectedCount: Int = 0

    var interactor: CharacterListInteractorProtocol

    private(set) var characters: [Character] = []
    private(set) var filteredCharacters: [Character] = []

    init(interactor: CharacterListInteractorProtocol) {
        self.interactor = interactor
    }

    func viewWillAppear() {
        viewWillAppearCount += 1
    }

    func viewDidLoad() {
        interactor.fetchCharacterList(refresh: false) { response in
            switch response {
            case .success(let data):
                self.characters = data
            case .failure:
                self.characters = []
            }
        }
    }

    func refreshData() {
        interactor.fetchCharacterList(refresh: true) { response in
            switch response {
            case .success(let data):
                self.characters = data
            case .failure:
                self.characters = []
            }
        }
    }

    func filterData(by text: String) {
        filteredCharacters = interactor.filterCharacter(with: text)
    }

    func numberOfSections() -> Int {
        1
    }

    func numberOfRowsInSections(_ section: Int) -> Int {
        characters.count
    }

    func willDisplay(for indexpath: IndexPath) {
        willDisplayCount += 1
    }

    func cellForRow(for indexPath: IndexPath) -> CharacterListViewController.UseCase {

        guard !characters.isEmpty else {
            return CharacterListViewController.UseCase.noResults("No Results")
        }

        let character = characters[indexPath.row]
        return CharacterListViewController.UseCase.showCharacter(.init(name: character.name, description: character.description ?? "", image: character.thumbnail))
    }

    func didSelect(for indexPath: IndexPath) {        
        didSelectedCount += 1
    }
}

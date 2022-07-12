//
//  CharacterListPresenter.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 2/7/22.
//

import Foundation

final class CharacterListPresenter {
    weak var view: CharacterListViewControllerProtocol?
    var coordinator: CharactersCoordinatorProtocol?

    var interactor: CharacterListInteractorProtocol

    private(set) var characters: [Character] = []
    private(set) var filteredCharacters: [Character] = []

    init(
        interactor: CharacterListInteractorProtocol,
        coordinator: CharactersCoordinatorProtocol
    ) {
        self.interactor = interactor
        self.coordinator = coordinator
    }
}

 // MARK: - CharacterListPresenterProtocol
extension CharacterListPresenter: CharacterListPresenterProtocol {

    func viewWillAppear() {
        view?.setupView()
    }

    func viewDidLoad() {
        view?.showLoader()
        interactor.fetchCharacterList(refresh: false) { result in
            switch result {
            case .success(let data):
                self.characters = data
                self.view?.hideLoader()
                self.view?.reloadData()
            case .failure(let error):
                self.view?.showAlertError(message: error.description(), completion: { [weak self] in
                    self?.view?.hideLoader()
                    self?.view?.reloadData()
                })
            }
        }
    }

    @objc func refreshData() {
        view?.showRefreshData()
        interactor.fetchCharacterList(refresh: true) { result in
            switch result {
            case .success(let data):
                self.characters = data
                self.view?.hideRefreshData()
                self.view?.reloadData()
            case .failure(let error):
                self.view?.showAlertError(message: error.description(), completion: { [weak self] in
                    self?.view?.hideRefreshData()
                    self?.view?.hideLoader()
                    self?.view?.reloadData()
                })
            }
        }
    }

    func filterData(by text: String) {
        filteredCharacters = interactor.filterCharacter(with: text)
        view?.reloadData()
    }

    func numberOfSections() -> Int {
        1
    }

    func numberOfRowsInSections(_ section: Int) -> Int {
        max(1, interactor.isSearching ? filteredCharacters.count : characters.count)
    }

    func cellForRow(for indexPath: IndexPath) -> CharacterListViewController.UseCase {

        if interactor.isSearching && filteredCharacters.isEmpty {
            return .noResults("noResults".localized)
        }

        guard !characters.isEmpty else {
            return .noResults("noResults".localized)
        }

        let character = interactor.isSearching ? filteredCharacters[indexPath.row] : characters[indexPath.row]
        let model = CharacterTableViewCell.Model(name: character.name, description: character.description ?? "", image: character.thumbnail)
        return .showCharacter(model)
    }

    func willDisplay(for indexPath: IndexPath) {
        guard indexPath.row == characters.count - 1 else {
            return
        }

        view?.showFooterSpinner()
        interactor.fetchCharacterList(refresh: false) { [weak self] result in
            
            if case let .success(data) = result {
                self?.characters = data
                self?.view?.reloadData()
            }
            self?.view?.hideFooterSpinner()
        }
    }

    func didSelect(for indexPath: IndexPath) {
        let character = interactor.isSearching ? filteredCharacters[indexPath.row] : characters[indexPath.row]
        coordinator?.showCharacterDetail(character: character)
    }
}

//
//  CharacterListBuilder.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 2/7/22.
//

import UIKit

final class CharacterListBuilder: Builder {

    let currentCoordinator: CharactersCoordinatorProtocol

    init(currentCoordinator: CharactersCoordinatorProtocol) {
        self.currentCoordinator = currentCoordinator
    }

    func build() -> UIViewController {
        let networkClient = CharacterListNetworkClient(baseURL: Constants.baseUrl)
        let database = RealmManager()
        let repository = CharacterListRepository(networkClient: networkClient, localDatabase: database)
        let interactor = CharacterListInteractor(repository: repository)
        let presenter = CharacterListPresenter(interactor: interactor, coordinator: currentCoordinator)
        let viewController = CharacterListViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}

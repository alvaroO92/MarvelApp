//
//  CharacterListRepository.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 1/7/22.
//

import Foundation

typealias CharacterListRepositoryCompletion = (Result<CharacterListRepository.CharacterListRepositoryReponseModel, NetworkError>)

protocol CharacterListRepositoryProtocol {
    func getCharacters(page: Int, completion: @escaping (CharacterListRepositoryCompletion) -> Void)
}

final class CharacterListRepository {
    let networkClient: CharacterListNetworkClientProtocol
    let localDatabase: RealmManagerProtocol

    init(
        networkClient: CharacterListNetworkClientProtocol,
        localDatabase: RealmManagerProtocol
    ) {
        self.networkClient = networkClient
        self.localDatabase = localDatabase
    }

    private func storeDataInLocalDatabase(_ result: MarvelCharactersResponseDTO) {
        DispatchQueue.main.async { [weak self] in
            self?.localDatabase.write(result)
        }
    }

    private func getLocalDatabaseStored() -> MarvelCharactersResponseDTO? {
        let response = localDatabase.object(fromEntity: MarvelCharactersResponseDTO.self)
        return response?.first
    }
}

extension CharacterListRepository: CharacterListRepositoryProtocol {
    func getCharacters(page: Int, completion: @escaping (CharacterListRepositoryCompletion) -> Void) {
        networkClient.getCharacters(page: page) { result in
            switch result {
            case .success(let data):
                NotificationCenter.default.post(name: .hideNoConnectionView, object: nil)
                do {
                    let decoder = JSONDecoder()
                    let decoded = try decoder.decode(MarvelCharactersResponseDTO.self, from: data)
                    self.storeDataInLocalDatabase(decoded)
                    let model = CharacterListRepositoryReponseModel(response: decoded.toDomain(), offlineMode: false)
                    completion(.success(model))
                } catch {
                    completion(.failure(.general(error)))
                }
            case .failure(let error):
                if error == .networkConnection, let stored = self.getLocalDatabaseStored() {
                    NotificationCenter.default.post(name: .showNoConnectionView, object: nil)
                    let model = CharacterListRepositoryReponseModel(response: stored.toDomain(), offlineMode: false)
                    completion(.success(model))
                } else {
                    completion(.failure(.general(error)))
                }

            }
        }
    }
}

extension CharacterListRepository {
    public struct CharacterListRepositoryReponseModel {
        let response: MarvelCharactersResponse
        let offlineMode: Bool

        init(response: MarvelCharactersResponse, offlineMode: Bool) {
            self.response = response
            self.offlineMode = offlineMode
        }
    }
}

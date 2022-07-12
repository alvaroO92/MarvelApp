//
//  CharacterListRepositoryStub.swift
//  MarvelAppTests
//
//  Created by Alvaro Orti Moreno on 3/7/22.
//

import XCTest
@testable import MarvelApp

final class CharacterListRepositoryStub: CharacterListRepositoryProtocol {

    let networkCient: CharactersNetworkClientStub
    let localDatabase: LocalDatabaseFake
    let offlineMode: Bool

    init(networkCient: CharactersNetworkClientStub,localDatabase: LocalDatabaseFake, offlineMode: Bool) {
        self.networkCient = networkCient
        self.localDatabase = localDatabase
        self.offlineMode = offlineMode
    }

    func getCharacters(page: Int, completion: @escaping (CharacterListRepositoryCompletion) -> Void) {

        guard !offlineMode else {
            completion(.failure(.networkConnection))
            return
        }

        networkCient.getCharacters(page: 0) { result in
            switch result {
            case .success:
                let fakeResponse = MarvelCharactersResponse(id: "", data: .init(id: "", results: [.init(id: 0, name: "test", description: "descrip", thumbnail: nil, resourceURI: nil)]))
                let model = CharacterListRepository.CharacterListRepositoryReponseModel(response: fakeResponse, offlineMode: self.offlineMode)
                completion(.success(model))
            case .failure(let error):
                if error == .networkConnection {
                    completion(.success(.init(response: .init(id: "", data: .init(id: "", results: [.init(id: 0, name: "test", description: "desc", thumbnail: nil, resourceURI: nil)])), offlineMode: false)))
                } else {
                    completion(.failure(error))
                }

            }
        }
    }
}

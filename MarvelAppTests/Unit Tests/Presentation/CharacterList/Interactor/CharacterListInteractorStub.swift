//
//  CharacterListInteractorStub.swift
//  MarvelAppTests
//
//  Created by Alvaro Orti Moreno on 3/7/22.
//

import Foundation
@testable import MarvelApp

final class CharacterListInteractorStub: CharacterListInteractorProtocol {

    var isSearching: Bool
    var networkError: NetworkError?

    init(isSearching: Bool, networkError: NetworkError?) {
        self.isSearching = isSearching
        self.networkError = networkError
    }

    func fetchCharacterList(refresh: Bool, completion: @escaping (Result<[Character], NetworkError>) -> Void) {

        if refresh {
            let character: Character = .init(id: 0, name: "refresher Name", description: "refresher Desc", thumbnail: nil, resourceURI: nil)
            completion(.success([character]))
        }

        guard let networkError = networkError else {
            let character: Character = .init(id: 0, name: "test", description: "test", thumbnail: nil, resourceURI: nil)
            completion(.success([character]))
            return
        }

        completion(.failure(networkError))
    }

    func filterCharacter(with text: String) -> [Character] {
        guard isSearching else {
            return []
        }

        let character: Character = .init(id: 0, name: "test", description: "test", thumbnail: nil, resourceURI: nil)

        return text.isEmpty ? [] : [character]
    }
}

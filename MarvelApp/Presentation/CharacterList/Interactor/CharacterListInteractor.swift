//
//  CharacterListInteractor.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 2/7/22.
//

import Foundation

final class CharacterListInteractor {
    private let repository: CharacterListRepositoryProtocol
    private var page: Int = 0
    private var characters: [Character] = []

    var needMoreFetcher: Bool = false
    var isSearching: Bool = false

    init(repository: CharacterListRepositoryProtocol) {
        self.repository = repository
    }
}

extension CharacterListInteractor: CharacterListInteractorProtocol {

    func filterCharacter(with text: String) -> [Character] {
        isSearching = !text.isEmpty

        let filtered = characters.filter { $0.name.contains(text) }
        return filtered
    }

    func fetchCharacterList(refresh: Bool, completion: @escaping (Result<[Character], NetworkError>) -> Void) {
        if refresh {
            page = 0
            needMoreFetcher = true
            characters.removeAll()
        }

        repository.getCharacters(page: page) { [weak self] (response) in
            guard let self = self else { return }
            
            switch response {
            case .success(let result):

                // Prevent to show non downloaded pages
                if !result.offlineMode {
                    self.page += result.response.data?.count ?? 0
                }

                self.needMoreFetcher = self.page <= Int(result.response.data?.limit ?? 0)
                let data = result.response.data

                // Prevent to has more pages to show AND not is offline mode
                if self.needMoreFetcher && !result.offlineMode {
                    self.characters.append(contentsOf: data?.results ?? [])
                }

                completion(.success(self.characters))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

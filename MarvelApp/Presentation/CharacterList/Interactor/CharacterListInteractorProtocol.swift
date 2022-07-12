//
//  CharacterListInteractorProtocol.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 2/7/22.
//

import Foundation

protocol CharacterListInteractorProtocol {
    func fetchCharacterList(refresh: Bool, completion: @escaping (Result<[Character], NetworkError>) -> Void)

    var isSearching: Bool { get set }
    func filterCharacter(with text: String) -> [Character]
}

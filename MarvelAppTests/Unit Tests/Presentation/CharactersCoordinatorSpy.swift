//
//  CharactersCoordinatorSpy.swift
//  MarvelAppTests
//
//  Created by Alvaro Orti Moreno on 3/7/22.
//

import Foundation
@testable import MarvelApp

final class CharactersCoordinatorSpy: CharactersCoordinatorProtocol {

    private(set) var showCharactersListCount: Int = 0
    private(set) var showCharacterDetailCount: Int = 0

    func showCharacterList() {
        showCharactersListCount += 1
    }
    func showCharacterDetail(character: Character) {
        showCharacterDetailCount += 1
    }
}

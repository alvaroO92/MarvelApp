//
//  CharacterDetailPresenterProtocol.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 2/7/22.
//

import Foundation

protocol CharacterDetailPresenterProtocol {
    func viewWillAppear()
    func viewConfig(completion: @escaping (CharacterDetailViewModel) -> Void)
}

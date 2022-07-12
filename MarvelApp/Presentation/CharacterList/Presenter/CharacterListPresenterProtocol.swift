//
//  CharacterListPresenterProtocol.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 2/7/22.
//

import Foundation

protocol CharacterListPresenterProtocol {
    func viewWillAppear()
    func viewDidLoad()
    func refreshData()
    func filterData(by text: String)
    func numberOfSections() -> Int
    func numberOfRowsInSections(_ section: Int) -> Int
    func willDisplay(for indexpath: IndexPath)
    func cellForRow(for indexPath: IndexPath) -> CharacterListViewController.UseCase
    func didSelect(for indexPath: IndexPath)
}

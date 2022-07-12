//
//  CharacterListViewControllerProtocol.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 2/7/22.
//

import Foundation

protocol CharacterListViewControllerProtocol: AnyObject {
    func setupView()
    func showFooterSpinner()
    func hideFooterSpinner()
    func showLoader()
    func hideLoader()
    func reloadData()
    func showRefreshData()
    func hideRefreshData()
    func showAlertError(message: String, completion: @escaping () -> Void)
}

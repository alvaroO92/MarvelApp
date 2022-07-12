//
//  Constants.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 1/7/22.
//

import Foundation

enum Constants {
    static let baseUrl = "https://gateway.marvel.com/v1/public/"
    static let limit = "100"
    static let privateKey = Bundle.main.infoDictionary?["PRIVATE_KEY"] as! String
    static let publicKey = Bundle.main.infoDictionary?["PUBLIC_KEY"] as! String
}

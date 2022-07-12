//
//  Localized+String.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 1/7/22.
//

import Foundation

extension String {
    public var localized: String {
        Bundle.main.localizedString(
            forKey: self,
            value: nil,
            table: "Localizable"
        )
    }
}

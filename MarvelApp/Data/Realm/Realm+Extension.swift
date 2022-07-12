//
//  Realm+Extension.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 1/7/22.
//

import RealmSwift

extension Results {
    func toArray() -> [Element] {
        return compactMap {
            $0
        }
    }
}

//
//  Character.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 28/6/22.
//

import Foundation

struct Character: Equatable {
    let id: Int
    let name: String
    let description: String?
    let thumbnail: Image?
    let resourceURI: String?

    static func == (lhs: Character, rhs: Character) -> Bool {
        lhs.id == rhs.id
    }
}

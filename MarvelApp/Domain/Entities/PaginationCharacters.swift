//
//  PaginationCharacters.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 2/7/22.
//

import Foundation

struct PaginationCharacters {
    let id: String?
    let offset: Int = 0
    let limit: Int = 0
    let total: Int = 0
    let count: Int = 0
    let results: [Character]

    func hasMore() -> Bool {
        return (offset + count) < total
    }
}

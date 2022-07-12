//
//  CharacterDetailViewModel.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 2/7/22.
//

import UIKit

struct CharacterDetailViewModel {
    let image: UIImage?
    let decription: String?

    init(image: UIImage?, description: String? = nil) {
        self.image = image
        self.decription = description
    }
}

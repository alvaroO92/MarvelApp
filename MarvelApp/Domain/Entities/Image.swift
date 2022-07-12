//
//  Image.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 28/6/22.
//

import UIKit

public struct Image: Equatable {
    let url: URL?

    func loadImage(completion: @escaping (UIImage?) -> ()) {
        guard let url = url else {
            completion(nil)
            return
        }

        let cacheImages: CacheImagesProtocol = CacheImages()
        let cacheImageRepository: CacheImagesRepositoryProtocol = CacheImagesRepository(cacheImages: cacheImages)
        cacheImageRepository.load(with: url, completion: completion)
    }
}

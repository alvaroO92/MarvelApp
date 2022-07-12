//
//  CacheImagesRepository.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 1/7/22.
//

import UIKit

protocol CacheImagesRepositoryProtocol {
    func load(with url: URL, completion: @escaping (UIImage?) -> ())
}

final class CacheImagesRepository {

    let cacheImages: CacheImagesProtocol

    init(cacheImages: CacheImagesProtocol) {
        self.cacheImages = cacheImages
        cleanOldFiles()
    }

    private func cleanOldFiles() {
        let maximumDays = 3.0 // 3 days
        let minimumDate = Date().addingTimeInterval(-maximumDays*24*60*60)
        func meetsRequirement(date: Date) -> Bool { return date < minimumDate }
        do {
            let manager = FileManager.default
            let documentDirUrl = try manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            if manager.changeCurrentDirectoryPath(documentDirUrl.path) {
                for file in try manager.contentsOfDirectory(atPath: ".") {
                    let creationDate = try manager.attributesOfItem(atPath: file)[FileAttributeKey.creationDate] as! Date
                    if  meetsRequirement(date: creationDate) {
                        try manager.removeItem(atPath: file)
                    }
                }
            }
        }
        catch {
            print("Cannot cleanup the old files: \(error)")
        }
    }
}

extension CacheImagesRepository: CacheImagesRepositoryProtocol {

    func load(with url: URL, completion: @escaping (UIImage?) -> ()) {
        if let imageCached = cacheImages.getImage(from: url) {
            completion(imageCached)
        }

        url.downloadImage { image in
            guard let image = image else {
                return completion(nil)
            }
            self.cacheImages.saveImage(image, url: url)
            completion(image)
        }
    }
}

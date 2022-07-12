//
//  CacheImagesFake.swift
//  MarvelAppTests
//
//  Created by Alvaro Orti Moreno on 3/7/22.
//

import XCTest
@testable import MarvelApp

final class CacheImagesFake: CacheImagesProtocol {
    func saveImage(_ image: UIImage, url: URL) { }
    func getImage(from url: URL) -> UIImage? { nil }
}

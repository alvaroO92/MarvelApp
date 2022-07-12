//
//  Load+UIImageView.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 1/7/22.
//

import UIKit

extension URL {

    func downloadImage(completion: @escaping (UIImage?) -> ()) {
        URLSession.shared.dataTask(with: self) { (data, response, error) in
            guard let data = data else {
                return completion(nil)
            }

            if let image = UIImage(data: data) {
                completion(image)
            }

        }.resume()
    }
}

//
//  Animation+UIView.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 1/7/22.
//

import UIKit

extension UIView {
    func animation(show: Bool) {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0 ,animations: {
            DispatchQueue.main.async { [weak self] in
                self?.alpha = show ? 1.0 : 0.0
            }
        }) { _ in
            self.isHidden = !show
        }
    }
}


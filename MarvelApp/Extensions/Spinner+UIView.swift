//
//  indicator+UIView.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 1/7/22.
//

import UIKit

extension UIView {
    func showActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(frame: frame)
        activityIndicator.center = center
        activityIndicator.style = .white
        activityIndicator.color = .black
        activityIndicator.backgroundColor = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        activityIndicator.tag = 100

        for subview in subviews {
            if subview.tag == 100 {
                print("already added")
                return
            }
        }

        addSubview(activityIndicator)
    }

    func hideActivityIndicator() {
        let activityIndicator = viewWithTag(100) as? UIActivityIndicatorView
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}

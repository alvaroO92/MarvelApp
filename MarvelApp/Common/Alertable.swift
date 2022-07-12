//
//  Alertable.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 1/7/22.
//

import UIKit

public protocol Alertable {}
public extension Alertable where Self: UIViewController {

    func showAlert(
        title: String = "",
        message: String,
        preferredStyle: UIAlertController.Style = .alert,
        completion: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "closeButton_title".localized, style: .default, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }
}

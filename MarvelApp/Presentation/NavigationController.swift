//
//  NavigationController.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 1/7/22.
//

import UIKit

class NavigationController: UINavigationController {

    lazy var noConnectionView: NoConnectionView = {
        let view = NoConnectionView()
        view.backgroundColor = Colors.App.offline01.uiColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "NoConnectionView"
        view.closeButtonTapped = {
            view.animation(show: false)
        }
        view.isHidden = true
        return view
    }()

    private var noConnectionViewHeight: CGFloat {
        UIFontMetrics.default.scaledValue(for: 44)
    }

    private lazy var noConnectionViewHeightConstraint: NSLayoutConstraint = noConnectionView.heightAnchor.constraint(equalToConstant: noConnectionViewHeight)

    override func loadView() {
        super.loadView()
        view.addSubview(noConnectionView)
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            noConnectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            noConnectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            noConnectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            noConnectionViewHeightConstraint
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(showNoConnectionView), name: .showNoConnectionView, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideNoConnectionView), name: .hideNoConnectionView, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .showNoConnectionView, object: nil)
        NotificationCenter.default.removeObserver(self, name: .hideNoConnectionView, object: nil)
    }

    @objc private func showNoConnectionView(notification: NSNotification) {
        noConnectionView.animation(show: true)
    }

    @objc private func hideNoConnectionView(notification: NSNotification) {
        noConnectionView.animation(show: false)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard previousTraitCollection != traitCollection else { return }
        noConnectionViewHeightConstraint.constant = noConnectionViewHeight
    }
}

//
//  NoConnectionView.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 1/7/22.
//

import UIKit

final class NoConnectionView: UIView {

    lazy var contentStackView: UIStackView = {
        let leftSpace = SpaceView(16, in: .horizontal)
        let rightSpace = SpaceView(16, in: .horizontal)
        let stackview = UIStackView(arrangedSubviews: [leftSpace, titleLabel, closeButton, rightSpace])
        stackview.axis = .horizontal
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "offline_title".localized
        label.textColor = Colors.App.text01.uiColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var closeButton: UIButton = {
        let button = UIButton()
        let imageButton = UIImage(named: "ic_closeButton")?.withRenderingMode(.alwaysOriginal)
        button.setImage(imageButton, for: .normal)
        button.setImage(imageButton, for: .focused)
        button.imageView?.tintColor = Colors.App.white01.uiColor
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    public var closeButtonTapped: () -> Void = {}

    override init(frame: CGRect) {
        super.init(frame: frame)
        fill(with: contentStackView)
        closeButton.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fill(with: contentStackView)
        closeButton.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
    }

    @objc
    func closeButtonTapped(_ sender: UIButton) {
        closeButtonTapped()
    }
}

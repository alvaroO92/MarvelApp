//
//  CharacterTableViewCell.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 2/7/22.
//

import UIKit

final class CharacterTableViewCell: UITableViewCell {
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.App.view01.uiColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var indicatorLoader: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: .zero)
        indicator.color = .black
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var textsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 1.0
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = Colors.App.text01.uiColor
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.App.text01.uiColor
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()

    private var containerViewHeight: CGFloat {
        UIFontMetrics.default.scaledValue(for: 100)
    }

    private lazy var containerViewHeightConstraint: NSLayoutConstraint = containerView.heightAnchor.constraint(equalToConstant: containerViewHeight)

    private var characterImageViewHeight: CGFloat {
        UIFontMetrics.default.scaledValue(for: 60)
    }

    private lazy var characterImageViewHeightConstraint: NSLayoutConstraint = characterImageView.heightAnchor.constraint(equalToConstant: characterImageViewHeight)

    private var characterImageViewWidth: CGFloat {
        UIFontMetrics.default.scaledValue(for: 60)
    }

    private lazy var characterImageViewWidthConstraint: NSLayoutConstraint = characterImageView.widthAnchor.constraint(equalToConstant: characterImageViewWidth)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        characterImageView.layer.masksToBounds = true
        characterImageView.layer.cornerRadius = 30
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
        descriptionLabel.text = ""
        characterImageView.image = nil
    }

    func setup() {
        self.selectionStyle = .none
        self.backgroundColor = .clear

        contentView.fill(with: containerView, edges: .init(top: 10, left: 10, bottom: 10, right: 10))

        NSLayoutConstraint.activate([
            containerViewHeightConstraint
        ])

        characterImageView.fill(with: indicatorLoader)
        containerView.addSubview(characterImageView)
        NSLayoutConstraint.activate([
            characterImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            characterImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            characterImageViewHeightConstraint,
            characterImageViewWidthConstraint
        ])

        containerView.addSubview(textsStackView)
        NSLayoutConstraint.activate([
            textsStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            textsStackView.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 16),
            textsStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
    }

    func display(with model: CharacterTableViewCell.Model) {
        nameLabel.text = model.name
        descriptionLabel.text = model.description

        indicatorLoader.isHidden = false
        indicatorLoader.startAnimating()
        if let image = model.image {
            image.loadImage { result in
                DispatchQueue.main.async { [weak self] in
                    self?.indicatorLoader.isHidden = true
                    self?.indicatorLoader.stopAnimating()
                    self?.characterImageView.image = result
                }
            }
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard previousTraitCollection != traitCollection else { return }
        containerViewHeightConstraint.constant = containerViewHeight
        characterImageViewHeightConstraint.constant = characterImageViewHeight
        characterImageViewWidthConstraint.constant = characterImageViewWidth
    }
}

extension CharacterTableViewCell {
    struct Model {
           let name: String
           let description: String
           let image: Image?

           init(name: String, description: String, image: Image?) {
               self.name = name
               self.description = description
               self.image = image
           }
       }
}

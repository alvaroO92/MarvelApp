//
//  CharacterDetailViewController.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 2/7/22.
//

import UIKit

final class CharacterDetailViewController: UIViewController {

    lazy var shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.App.shadow01.uiColor
        view.alpha = 0.7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = Colors.App.white01.uiColor
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var presenter: CharacterDetailPresenterProtocol

    override func loadView() {
        super.loadView()
        view.fill(with: characterImageView)
        view.fill(with: shadowView)

        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    init(presenter: CharacterDetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewConfig { model in
            DispatchQueue.main.async { [weak self] in
                self?.descriptionLabel.text = model.decription
                self?.characterImageView.image = model.image
            }
        }
    }
}

extension CharacterDetailViewController: CharacterDetailViewControllerProtocol {

    func setupView() {
        title = "characterDetail_title".localized
        view.backgroundColor = Colors.App.view02.uiColor
    }
}

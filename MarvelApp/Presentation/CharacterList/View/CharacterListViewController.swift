//
//  CharacterListViewController.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 2/7/22.
//

import UIKit

final class CharacterListViewController: UITableViewController {

    enum UseCase {
        case showCharacter(CharacterTableViewCell.Model)
        case noResults(String)
    }

    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        return refreshControl
    }()

    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "search".localized
        searchController.searchBar.searchBarStyle = .minimal
        searchController.definesPresentationContext = true
        searchController.searchResultsUpdater = self
        return searchController
    }()

    private var presenter: CharacterListPresenterProtocol

    init(presenter: CharacterListPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    @objc private func refreshData() {
        presenter.refreshData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSections(section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = presenter.cellForRow(for: indexPath)

        switch cell {
        case .showCharacter(let data):
            let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as! CharacterTableViewCell
            cell.display(with: data)
            return cell
        case .noResults(let message):
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.textLabel?.text = message
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter.willDisplay(for: indexPath)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(for: indexPath)
    }
}

extension CharacterListViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        presenter.filterData(by: searchController.searchBar.text ?? "")
    }
}

extension CharacterListViewController: CharacterListViewControllerProtocol, Alertable {
    func setupView() {
        title = "characterList_title".localized
        tableView.tableHeaderView = searchController.searchBar
        tableView.backgroundView = nil
        tableView.backgroundColor = Colors.App.view02.uiColor
        tableView.refreshControl = refresher
        refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "CharacterTableViewCell")
        tableView.register(UITableViewCell.self,
                            forCellReuseIdentifier: "UITableViewCell")
        tableView.separatorStyle = .none
    }

    func showRefreshData() {
        DispatchQueue.main.async { [weak self] in
            self?.refresher.beginRefreshing()
        }
    }

    func hideRefreshData() {
        DispatchQueue.main.async { [weak self] in
            self?.refresher.endRefreshing()
        }
    }

    func showFooterSpinner() {
        DispatchQueue.main.async { [weak self] in
            let spinner = UIActivityIndicatorView(style: .gray)
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self?.tableView.bounds.width ?? 0.0, height: CGFloat(44))
            spinner.startAnimating()
            self?.tableView.tableFooterView = spinner
            self?.tableView.tableFooterView?.isHidden = false
        }
    }

    func hideFooterSpinner() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.tableFooterView?.removeFromSuperview()
            let view = UIView()
            view.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self?.tableView.bounds.width ?? 0.0, height: CGFloat(5))
            self?.tableView.tableFooterView = view
            self?.tableView.tableFooterView?.isHidden = true
        }
    }

    func showLoader() {
        DispatchQueue.main.async { [weak self] in
            self?.view.showActivityIndicator()
        }
    }

    func hideLoader() {
        DispatchQueue.main.async { [weak self] in
            self?.view.hideActivityIndicator()
        }
    }

    func showAlertError(message: String, completion: @escaping () -> Void) {
        DispatchQueue.main.async { [weak self] in
            self?.showAlert(message: message, completion: completion)
        }
    }

    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

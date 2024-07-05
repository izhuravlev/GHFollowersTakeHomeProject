//
//  FavouritesListVC.swift
//  TakeHomePrep
//
//  Created by Ilya Zhuravlev on 2024-06-13.
//

import UIKit

class FavouritesListVC: izDataLoadingVC {

    let tableView              = UITableView()
    var favorites: [Follower]  = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavourites()
    }

    func configureViewController() {
        view.backgroundColor    = .systemBackground
        title                   = "Favourites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(FavouriteCell.self, forCellReuseIdentifier: FavouriteCell.reuseID)
    }

    func getFavourites() {
        PersistenceManager.retrieveFavourites { [weak self] result in
            guard let self = self else {return}

            switch result {
            case .success( let favorites):
                if favorites.isEmpty {
                    // show empty state
                    showEmptyStateView(with: "No Favorites Yet!\nAdd one from the follower screen.", view: self.view)
                } else {
                    // display favorites
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            case .failure( let error):
                self.presentIZAlertOnMainThread(title: "Smth went wrong!", message: error.rawValue, buttonTitle: "Okay")
            }
        }
    }
}

extension FavouritesListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteCell.reuseID) as! FavouriteCell
        let favourite = favorites[indexPath.row]
        cell.set(favourite: favourite)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favourite = favorites[indexPath.row]
        let destVC = FollowerListVC(username: favourite.login)

        navigationController?.pushViewController(destVC, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)

        PersistenceManager.updateWith(favourite: favorite,
                                      actionType: .remove) { [weak self] error in
            guard let self = self else {return}
            guard let error = error else {
                return
            }
            self.presentIZAlertOnMainThread(title: "Something went wrong!", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}

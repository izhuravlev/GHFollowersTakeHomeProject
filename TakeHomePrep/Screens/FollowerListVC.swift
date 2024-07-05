//
//  FollowerListVC.swift
//  TakeHomePrep
//
//  Created by Ilya Zhuravlev on 2024-06-14.
//

import UIKit

protocol FollowerListVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class FollowerListVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var username: String!
    var pageCounter: Int = 1
    var hasMoreFollowers = true
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    let perPage = NetworkManager.shared.itemsPerPage
    
    var isSearching = false
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: pageCounter)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(izFollowerCell.self, forCellWithReuseIdentifier: izFollowerCell.reuseID)
    }

    func getFollowers(username: String, page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: pageCounter) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                if followers.count < perPage {self.hasMoreFollowers = false}
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers. Go Follow them ;)"
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, view: self.view)
                        return
                    }
                    
                }
                self.updateData(on: self.followers)
                
            case .failure(let error):
                self.presentIZAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Okay")
            }
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: izFollowerCell.reuseID, for: indexPath) as! izFollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    @objc func addButtonTapped() {
        // persistance manager magic
        
        // show loading
        showLoadingView()
        // make a network call to get the avatar and user name
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else {return}
            // hide loading
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                // save info to persistence
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                PersistenceManager.updateWith(favourite: favorite, 
                                              actionType: .add) { [weak self] error in
                    guard let self = self else {return}
                    guard let error = error else {
                        self.presentIZAlertOnMainThread(title: "Success!", message: "User has been added to Favorites!", buttonTitle: "Awesome!")
                        return
                    }
                    self.presentIZAlertOnMainThread(title: "Oh oh", message: error.rawValue, buttonTitle: "Ok")
                }
            case .failure(let error):
                self.presentIZAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
        
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            pageCounter += 1
            getFollowers(username: username, page: pageCounter)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray     = isSearching ? filteredFollowers : followers
        let follower        = activeArray[indexPath.item]
        
        let destVC          = UserInfoVC()
        destVC.userName     = follower.login
        destVC.delegate     = self
        let navController   = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            return
        }
        isSearching = true
        filteredFollowers = followers.filter{$0.login.lowercased().contains(filter.lowercased())}
        updateData(on: self.filteredFollowers)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: followers)
        isSearching = false
    }
    
}

extension FollowerListVC: FollowerListVCDelegate {
    
    func didRequestFollowers(for username: String) {
        self.username       = username
        title               = username
        pageCounter         = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: pageCounter)
    }
}

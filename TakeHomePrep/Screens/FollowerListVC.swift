//
//  FollowerListVC.swift
//  TakeHomePrep
//
//  Created by Ilya Zhuravlev on 2024-06-14.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var username: String!
    var pageCounter: Int = 1
    
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemRed
        collectionView.register(izFollowerCell.self, forCellWithReuseIdentifier: izFollowerCell.reuseID)
    }

    func getFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: pageCounter) { result in
            switch result {
            case .success(let followers):
                print(followers)
                
            case .failure(let error):
                self.presentIZAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Okay")
            }
        }
    }
    
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width                   = view.bounds.width
        let padding: CGFloat        = 12
        let minItemSpacing: CGFloat = 10
        let availableWidth: CGFloat = width - (padding * 2) - (minItemSpacing * 2)
        let itemWidth: CGFloat      = availableWidth / 3
        
        let flowLayout              = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
}

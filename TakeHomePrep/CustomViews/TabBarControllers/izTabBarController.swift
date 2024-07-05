//
//  izTabBarController.swift
//  TakeHomePrep
//
//  Created by Ilya Zhuravlev on 2024-07-05.
//

import UIKit

class izTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor         = .systemGreen
        UITabBar.appearance().backgroundColor   = .systemGray5
        self.viewControllers                    = [createSearchNC(), createFavouritesNC()]

    }

    func createSearchNC() -> UINavigationController {
        let searchVC        = SearchVC()
        searchVC.title      = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavouritesNC() -> UINavigationController {
        let favouritesVC = FavouritesListVC()
        favouritesVC.title = "Favourites"
        favouritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favouritesVC)
    }
}

//
//  FollowerListVC.swift
//  TakeHomePrep
//
//  Created by Ilya Zhuravlev on 2024-06-14.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }


}

//
//  izRepoItemVC.swift
//  TakeHomePrep
//
//  Created by Ilya Zhuravlev on 2024-07-03.
//

import UIKit

class izRepoItemVC: izItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, with: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
}

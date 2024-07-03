//
//  izFollowerItemVC.swift
//  TakeHomePrep
//
//  Created by Ilya Zhuravlev on 2024-07-03.
//

import UIKit

class izFollowerItemVC: izItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, with: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, with: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}

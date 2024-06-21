//
//  izAvatarImageView.swift
//  TakeHomePrep
//
//  Created by Ilya Zhuravlev on 2024-06-21.
//

import UIKit

class izAvatarImageView: UIImageView {
    
    let placeholderImage = UIImage(named: "avatar-placeolder")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }

}

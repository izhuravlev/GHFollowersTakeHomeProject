//
//  izAlertContainerView.swift
//  TakeHomePrep
//
//  Created by Ilya Zhuravlev on 2024-07-05.
//

import UIKit

class izAlertContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        // custom code
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = UIColor.label.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }

}

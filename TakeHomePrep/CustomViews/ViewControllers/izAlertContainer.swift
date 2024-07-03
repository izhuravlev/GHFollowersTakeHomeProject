//
//  izAlertContainer.swift
//  TakeHomePrep
//
//  Created by Ilya Zhuravlev on 2024-06-15.
//

import UIKit

class izAlertContainer: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        // custom code
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    private func configure() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = UIColor.label.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }

}

//
//  izTextField.swift
//  TakeHomePrep
//
//  Created by Ilya Zhuravlev on 2024-06-13.
//

import UIKit

class izTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius          = 10
        layer.borderWidth           = 2
        layer.borderColor           = UIColor.systemGray4.cgColor
        
        textColor                   = .label
        tintColor                   = .label
        textAlignment               = .center
        font                        = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 12
        
        backgroundColor             = .tertiarySystemBackground
        autocorrectionType          = .no
        spellCheckingType           = .no
        inputAccessoryView          = .none
        returnKeyType               = .go
        clearButtonMode             = .whileEditing
        placeholder                 = "Enter a Username"
    }
}

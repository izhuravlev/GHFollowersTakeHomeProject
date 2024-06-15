//
//  UiViewController+Ext.swift
//  TakeHomePrep
//
//  Created by Ilya Zhuravlev on 2024-06-15.
//

import UIKit

extension UIViewController {
    func presentIZAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = izAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}

//
//  izDataLoadingVC.swift
//  TakeHomePrep
//
//  Created by Ilya Zhuravlev on 2024-07-05.
//

import UIKit

class izDataLoadingVC: UIViewController {

    var containerView: UIView!

    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)

        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0

        UIView.animate(withDuration: 0.5) {
            self.containerView.alpha = 0.8
        }

        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])

        activityIndicator.startAnimating()
    }

    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }

    func showEmptyStateView(with message: String, view: UIView) {
        let emptyStateView = izEmptyStateView(message: message)
        emptyStateView.frame = view.safeAreaLayoutGuide.layoutFrame
        view.addSubview(emptyStateView)
    }
}

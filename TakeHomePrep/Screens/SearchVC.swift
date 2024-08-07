//
//  SearchVC.swift
//  TakeHomePrep
//
//  Created by Ilya Zhuravlev on 2024-06-13.
//

import UIKit

class SearchVC: UIViewController {

    let logoImageView = UIImageView()
    let userNameTextField = izTextField()
    let callToACtionButton = izButton(backgroundColor: .systemGreen,
                                      title: "Get Followers")
    var logoImageViewTopConstraint = NSLayoutConstraint()
    var isUserNameEntered: Bool { return !userNameTextField.text!.isEmpty }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCTAButton()
        createDismissKeyboardTapGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        userNameTextField.text = ""
    }

    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }

    @objc func pushFollowerListVC() {
        guard isUserNameEntered else {
            presentIZAlertOnMainThread(title: "Empty Username!", 
                                       message: "Please Enter a Username! We need to know who to look for! 😉",
                                       buttonTitle: "Okay")
            return
        }

        userNameTextField.resignFirstResponder()

        let followerListVC = FollowerListVC(username: userNameTextField.text!)
        navigationController?.pushViewController(followerListVC, animated: true)
    }

    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo

        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80

        logoImageViewTopConstraint = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                                        constant: topConstraintConstant)
        logoImageViewTopConstraint.isActive = true

        NSLayoutConstraint.activate([
            // 4 constrains max: height, width, x and y coords
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    func configureTextField() {
        view.addSubview(userNameTextField)
        userNameTextField.delegate = self

        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func configureCTAButton() {
        view.addSubview(callToACtionButton)
        callToACtionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            callToACtionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToACtionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToACtionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToACtionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension SearchVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}

//
//  izUserInfoVC.swift
//  TakeHomePrep
//
//  Created by Ilya Zhuravlev on 2024-07-02.
//

import UIKit

class izUserInfoHeaderVC: UIViewController {
    
    let avatarImageView     = izAvatarImageView(frame: .zero)
    let userNameLabel       = izTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel           = izSecondaryLabel(fontSize: 18)
    let locationImageView   = UIImageView()
    let locationLabel       = izSecondaryLabel(fontSize: 18)
    let bioLabel            = izBodyLabel(textAlignment: .left)
    
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutUI()
        configureUIElemenets()

        // Do any additional setup after loading the view.
    }
    
    func addSubviews() {
        view.addSubview(avatarImageView)
        view.addSubview(userNameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }
    
    func layoutUI() {
        let padding: CGFloat            = 20
        let textImagePadding: CGFloat   = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // avatar to the top left corner of the view, with square height and width
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            // username to the right of the avatar, tops aligned with avatar,
            // trailing at the end of the screen, fixed height
            userNameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            userNameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            // name centered to the avatar, to the right of the avatar,
            // till the end of the screen, fixed height
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            // location image to the right of the avatar, bottom alligned with avatar,
            // fixed square dimensions
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            // location label to the right of the locationImage, centered to locImg,
            // trailing till the end of screen, fixed height
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            // bio aligned with the left avatar border, till the end of the screen,
            // right under all the previous views and fixed height of 3 lines (20 * 2)
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configureUIElemenets() {
        avatarImageView.downloadImage(from: user.avatarUrl)
        userNameLabel.text      = user.login
        nameLabel.text          = user.name ?? ""
        locationLabel.text      = user.location ?? "No Location"
        bioLabel.text           = user.bio ?? "No Bio Available"
        bioLabel.numberOfLines  = 3
        
        locationImageView.image = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
    }
    

    

}

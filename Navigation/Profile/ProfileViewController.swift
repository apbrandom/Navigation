//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 04.01.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let profileHeaderView = ProfileHeaderView()
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        profileHeaderView.backgroundColor = .lightGray
        return profileHeaderView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile"
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(profileHeaderView)
        setupProfileHeaderView()
    }
    
    //MARK: - Methods:
    
    func setupProfileHeaderView() {
        
        NSLayoutConstraint.activate([
            profileHeaderView.leftAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leftAnchor),
            profileHeaderView.rightAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.rightAnchor),
            profileHeaderView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                                    ])
    }
    
}



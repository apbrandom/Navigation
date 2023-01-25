//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 04.01.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var newButton: UIButton = {
        let button = UIButton()
        button.setTitle("New Button", for: .normal)
        button.backgroundColor = UIColor.red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile"
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(profileHeaderView)
        view.addSubview(newButton)
        setupProfileHeaderView()
    }
    
    //MARK: - Methods:
    
    func setupProfileHeaderView() {
        NSLayoutConstraint.activate([
            profileHeaderView.leftAnchor.constraint(
                equalTo: view.leftAnchor),
            profileHeaderView.rightAnchor.constraint(
                equalTo: view.rightAnchor),
            profileHeaderView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.heightAnchor.constraint(
                equalToConstant: 220),

            newButton.leftAnchor.constraint(
                equalTo: view.leftAnchor),
            newButton.rightAnchor.constraint(
                equalTo: view.rightAnchor),
            newButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            newButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}



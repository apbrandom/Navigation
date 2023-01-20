//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 04.01.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var profileHeaderView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile"
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(profileHeaderView)
        profileHeaderView.addSubview(profileHeaderView.catView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupProfileHeaderView()
//        setupCatView()
     
    }
    
    //MARK: - Methods:
    
    func setupProfileHeaderView() {
        profileHeaderView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        profileHeaderView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        profileHeaderView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
//    func setupCatView() {
//        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
//        profileHeaderView.catView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        profileHeaderView.catView.
//    }

}

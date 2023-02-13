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
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tuneView()
        addSubviews()
        setupConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    }
    
    
    //MARK: - Privte
    
    private func tuneView() {
        navigationItem.title = "Profile"
        view.backgroundColor = UIColor.systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(profileHeaderView)
        view.addSubview(newButton)
    }
    
    private func removeKevboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    

     private func setupConstrains() {
        NSLayoutConstraint.activate([
            profileHeaderView.leftAnchor.constraint(equalTo: view.leftAnchor),
            profileHeaderView.rightAnchor.constraint(equalTo: view.rightAnchor),
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),

            newButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            newButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            newButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            newButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}



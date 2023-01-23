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
        profileHeaderView.setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

    }
    
    //MARK: - Methods:
    
    func setupProfileHeaderView() {
        NSLayoutConstraint.activate([
            profileHeaderView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            profileHeaderView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                                    ])
    }
    
    @objc func buttonPressed() {
        
            let alertController = UIAlertController(title: "Change status of cat", message: "Come up with a funny status for the cat", preferredStyle: .alert)
            let action0 = UIAlertAction(title: "OK", style: .default) { (action0) in
                let text = alertController.textFields?.first?.text
//                print(text ?? "no text")
                self.profileHeaderView.statusLabel.text = text ?? "No status"
            }
                alertController.addTextField { (textFiled) in
                    textFiled.placeholder = "Enter the status"
                    
                }
                
                let action1 = UIAlertAction(title: "Cancel", style: .cancel)
                alertController.addAction(action0)
                alertController.addAction(action1)
            
        self.present(alertController, animated: true)
    }
    
}

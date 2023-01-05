//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 04.01.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Profile"
        self.view.backgroundColor = UIColor.systemBackground
        var tabBarItem = UITabBarItem()

        tabBarItem = UITabBarItem(title: "Profile",
                                  image: UIImage(systemName: "person"),
                                  selectedImage: nil)

        self.tabBarItem = tabBarItem
    }

}

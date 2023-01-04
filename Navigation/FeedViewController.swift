//
//  ViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 26.12.2022.
//

import UIKit

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Feed"
        self.view.backgroundColor = UIColor.green
        var tabBarItem = UITabBarItem()

        tabBarItem = UITabBarItem(title: "Feed",
                                  image: UIImage(systemName: "folder.badge.person.crop"),
                                  selectedImage: nil)

        self.tabBarItem = tabBarItem
    }


}


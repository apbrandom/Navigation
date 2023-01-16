//
//  ViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 26.12.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    var post = Post(title: "Post")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Feed"
        self.view.backgroundColor = UIColor.systemBackground
        
        tabBarItem()
        postButton()
        
    }
    
    //MARK: - Methods
    
    fileprivate func tabBarItem() {
        
        var tabBarItem = UITabBarItem()
        tabBarItem = UITabBarItem(title: "Feed",
                                  image: UIImage(
                                  systemName: "folder.badge.person.crop"),
                                  selectedImage: nil)
        self.tabBarItem = tabBarItem
        
    }
    
    fileprivate func postButton() {
        var postButton = UIButton()
        postButton = UIButton(type: .system)
        postButton.frame = CGRect(x: 140, y: 600, width: 130, height: 45)
        postButton.center = self.view.center
        postButton.layer.cornerRadius = 5
        postButton.setTitle("Post", for: .normal)
        postButton.backgroundColor = UIColor.orange
        self.view.addSubview(postButton)
        postButton.addTarget(self, action: #selector(postButtonPressed), for: .touchUpInside)
    }
    
    @objc func postButtonPressed() {
        let postVC = PostViewController()
        postVC.post = post
        navigationController?.pushViewController(postVC, animated: true)
    }
    
}


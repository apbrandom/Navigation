//
//  ViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 26.12.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    var post = Post(title: "Post")
    
    let postButton: UIButton = {
        let postButton = UIButton(frame: CGRect(x: 140, y: 600, width: 130, height: 45))
        postButton.layer.cornerRadius = 5
        postButton.setTitle("Post", for: .normal)
        postButton.backgroundColor = UIColor.orange
        return postButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Feed"
        self.view.backgroundColor = UIColor.systemBackground
        view.addSubview(postButton)
        postButton.addTarget(self, action: #selector(postButtonPressed), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        postButton.center = view.center
    }
    
    //MARK: - Methods
    
    @objc func postButtonPressed() {
        let postVC = PostViewController()
        postVC.post = post
        navigationController?.pushViewController(postVC, animated: true)
    }
    
}


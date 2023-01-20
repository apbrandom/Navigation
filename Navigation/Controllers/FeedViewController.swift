//
//  ViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 26.12.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    var post = Post(title: "Post")
    
    let feedView = UIView(frame: CGRect(x: 50, y: 50, width: 200, height: 200))
    
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
        view.backgroundColor = UIColor.systemBackground
        postButton.addTarget(self, action: #selector(postButtonPressed), for: .touchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
         view.addSubview(feedView)
         view.addSubview(postButton)
         setupFeedView()
        
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
    
    func setupFeedView() {
        feedView.backgroundColor = UIColor.lightGray
        
        feedView.translatesAutoresizingMaskIntoConstraints = false
        feedView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        feedView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        feedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        feedView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

    }

}


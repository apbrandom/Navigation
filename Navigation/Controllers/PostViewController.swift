//
//  PostViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 04.01.2023.
//

import UIKit

class PostViewController: UIViewController {
    
    var post = Post(title: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = post.title
        view.backgroundColor = UIColor.darkGray

    }
    
}

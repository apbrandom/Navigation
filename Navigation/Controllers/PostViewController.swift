//
//  PostViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 04.01.2023.
//

import UIKit

class PostViewController: UIViewController {
    
    var post = Post(title: "")
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tuneView()
        addSubview()
    }
    
    //MARK: - Private
    
    private func tuneView() {
        navigationItem.title = post.title
        view.backgroundColor = UIColor.darkGray
    }
    
    private func addSubview() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .done, target: self, action: #selector(infoBarButtonItemPressed))
    }
    
    //MARK: - Action
    
    @objc func infoBarButtonItemPressed() {
        let infoVC = InfoViewController()
        navigationController?.pushViewController(infoVC, animated: true)
    }
    
}

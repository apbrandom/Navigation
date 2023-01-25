//
//  ViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 26.12.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    var post = Post(title: "Post")
    
    let feedView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let firstButton: UIButton = {
        let button = UIButton()
        button.setTitle("First Button", for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 5
        return button
    }()
    
    let secondButton: UIButton = {
        let button = UIButton()
        button.setTitle("Second Button", for: .normal)
        button.backgroundColor = .brown
        button.layer.cornerRadius = 5
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 5
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Feed"
        view.backgroundColor = .systemBackground
        
        firstButton.addTarget(self, action: #selector(firstButtonPressed), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(secondButtonPressed), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(feedView)
        feedView.addSubview(postStackView)
        postStackView.addArrangedSubview(firstButton)
        postStackView.addArrangedSubview(secondButton)
        setupFeedView()
    }
    
    //MARK: - Methods
    
    @objc func firstButtonPressed() {
        let postVC = PostViewController()
        postVC.post = post
        navigationController?.pushViewController(postVC, animated: true)
    }
    
    @objc func secondButtonPressed() {
        let postVC = PostViewController()
        postVC.post = post
        navigationController?.pushViewController(postVC, animated: true)
    }
    
    func setupFeedView() {
        
        NSLayoutConstraint.activate([
            feedView.leftAnchor.constraint(
                equalTo: view.leftAnchor),
            feedView.rightAnchor.constraint(
                equalTo: view.rightAnchor),
            feedView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            feedView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            postStackView.centerXAnchor.constraint(
                equalTo: feedView.centerXAnchor),
            postStackView.centerYAnchor.constraint(
                equalTo: feedView.centerYAnchor),
            postStackView.widthAnchor.constraint(
                equalToConstant: 270),
            postStackView.heightAnchor.constraint(
                equalToConstant: 110),
            
        ])
        
    }

}


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
    
    private lazy var firstButton: UIButton = {
        let button = UIButton()
        button.setTitle("First Button", for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 5
        button.addTarget(
            self,
            action: #selector(firstButtonPressed(_:)),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var secondButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Second Button", for: .normal)
        button.backgroundColor = .brown
        button.layer.cornerRadius = 5
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 5
        button.addTarget(
            self,
            action: #selector(secondButtonPressed(_:)),
            for: .touchUpInside
        )
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tuneView()
        addSubviews()
        setupConstrains()
        
    }
    
    //MARK: - Private
    
    private func tuneView() {
        self.navigationItem.title = "Feed"
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(feedView)
        feedView.addSubview(postStackView)
        postStackView.addArrangedSubview(firstButton)
        postStackView.addArrangedSubview(secondButton)
    }
    
    @objc private func firstButtonPressed(_ sender: UIResponder) {
        let postVC = PostViewController()
        postVC.post = post
        navigationController?.pushViewController(postVC, animated: true)
    }
    
    @objc private func secondButtonPressed(_ sender: UIResponder) {
        let postVC = PostViewController()
        postVC.post = post
        navigationController?.pushViewController(postVC, animated: true)
    }
    
    func setupConstrains() {
        
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


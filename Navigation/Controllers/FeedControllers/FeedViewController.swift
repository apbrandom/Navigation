//
//  ViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 26.12.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    var post = Post?.self
    
    //MARK: - Subviews
    
    let feedView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
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
    
    private lazy var firstButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("First Button", for: .normal)
        button.backgroundColor = .systemBlue
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
    
    private lazy var secondButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Second Button", for: .normal)
        button.tintColor = .systemBackground
        button.backgroundColor = .systemBlue
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
        
        setupView()
        addSubviews()
        setupConstrains()
    }
    
    //MARK: - Private
    
    private func setupView() {
        
        title = "Feed"
        view.backgroundColor = .secondarySystemBackground
        
        tabBarItem = UITabBarItem(
            title: "Feed",
            image: UIImage(systemName: "house"),
            tag: 0
        )
    }
    
    private func addSubviews() {
        view.addSubview(feedView)
        feedView.addSubview(postStackView)
        postStackView.addArrangedSubview(firstButton)
        postStackView.addArrangedSubview(secondButton)
    }
    
    //MARK: - Action
    
    @objc func firstButtonPressed(_ sender: UIResponder) {
        let postVC = PostViewController()
        navigationController?.pushViewController(postVC, animated: true)
    }
    
    @objc func secondButtonPressed(_ sender: UIResponder) {
        let postVC = PostViewController()
        navigationController?.pushViewController(postVC, animated: true)
    }
    
    //MARK: - Layout
    
    func setupConstrains() {
        NSLayoutConstraint.activate([
            feedView.leftAnchor.constraint(equalTo: view.leftAnchor),
            feedView.rightAnchor.constraint(equalTo: view.rightAnchor),
            feedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            feedView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            postStackView.centerXAnchor.constraint(equalTo: feedView.centerXAnchor),
            postStackView.centerYAnchor.constraint(equalTo: feedView.centerYAnchor),
            postStackView.widthAnchor.constraint(equalToConstant: 270),
            postStackView.heightAnchor.constraint(equalToConstant: 110),
        ])
    }
    
}


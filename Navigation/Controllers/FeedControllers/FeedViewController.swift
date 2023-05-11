//
//  ViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 26.12.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    let feedModel = FeedModel()
    
    //MARK: - Subviews
    
    private lazy var feedView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var indicationLabel: UILabel = {
        let label = CircularLabel()
        label.backgroundColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var itemsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var newTextFiled: UITextField = {
        let textField = UITextField()
        textField.text = "secret"
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray5
        return textField
    }()
    
    private lazy var checkGuessButton: UIButton = {
        let button = CustomButton()
        button.setTitle("Check", for: .normal)
        
        button.pressed = {
            guard let text = self.newTextFiled.text, !text.isEmpty else {return}
            let isCorect = self.feedModel.check(word: text)
            self.indicationLabel.backgroundColor = isCorect ? .green : .red
        }
        return button
    }()
    
    private lazy var firstButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("First Button", for: .normal)

        button.pressed = {
            let postVC = PostViewController()
            self.navigationController?.pushViewController(postVC, animated: true)
        }
        return button
    }()
    
    private lazy var secondButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Second Button", for: .normal)

        button.pressed = {
            let postVC = PostViewController()
            self.navigationController?.pushViewController(postVC, animated: true)
        }
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
        feedView.addSubview(itemsStackView)
        feedView.addSubview(indicationLabel)
        itemsStackView.addArrangedSubview(newTextFiled)
        itemsStackView.addArrangedSubview(checkGuessButton)
        itemsStackView.addArrangedSubview(firstButton)
        itemsStackView.addArrangedSubview(secondButton)
    }
    
    //MARK: - Layout
    
    func setupConstrains() {
        feedView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        indicationLabel.snp.makeConstraints { make in
            make.centerX.equalTo(feedView.snp.centerX)
            make.width.height.equalTo(50)
            make.bottom.equalTo(itemsStackView.snp.top).offset(-90)
            
        }
        
        itemsStackView.snp.makeConstraints { make in
            make.centerX.equalTo(feedView.snp.centerX)
            make.centerY.equalTo(feedView.snp.centerY)
            make.width.equalTo(270)
            make.height.equalTo(220)
        }
    }
}


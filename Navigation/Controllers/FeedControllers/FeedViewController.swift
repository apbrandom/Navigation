//
//  ViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 26.12.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    weak var coordinator: FeedCoordinatable?
    let viewModel = FeedViewModel()
    private let passwordCracking = PasswordCrack()
    var passwordToCrack: String = ""
    
    //MARK: - Subviews
    
    private lazy var feedView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var statusPasswordLabel: UILabel = {
        let label = CircularLabel()
        label.backgroundColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var itemsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.text = "test"
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray5
        return textField
    }()
    
    private lazy var checkButton: UIButton = {
        let button = CustomButton()
        button.setTitle("Check", for: .normal)
        return button
    }()
    
    private lazy var generateAndCrackButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Generate and Crack", for: .normal)
        button.pressed = { [self] in
            self.passwordToCrack = self.passwordCracking.generateRandomPassword(length: 4)
            passwordTextField.isSecureTextEntry = true
            passwordTextField.text = passwordToCrack
            activityIndicator.startAnimating()
        
            DispatchQueue.global().async { [weak self] in
                self?.passwordCracking.bruteForce(passwordToUnlock: self?.passwordToCrack ?? "")
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.passwordTextField.isSecureTextEntry = false
                    self?.statusPasswordLabel.backgroundColor = .green
                }
            }
        }
        return button
    }()
    
    private lazy var postVCButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("PostVC", for: .normal)
        button.pressed = { self.coordinator?.navigateToPostVC() }
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
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func addSubviews() {
        view.addSubview(feedView)
        feedView.addSubview(itemsStackView)
        feedView.addSubview(statusPasswordLabel)
        feedView.addSubview(activityIndicator)
        itemsStackView.addArrangedSubview(passwordTextField)
        itemsStackView.addArrangedSubview(checkButton)
        itemsStackView.addArrangedSubview(generateAndCrackButton)
        itemsStackView.addArrangedSubview(postVCButton)
    }
    
    //MARK: - Layout
    
    func setupConstrains() {
        feedView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        statusPasswordLabel.snp.makeConstraints { make in
            make.centerX.equalTo(feedView.snp.centerX)
            make.width.height.equalTo(50)
            make.top.equalTo(feedView.snp.top).offset(90)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(feedView.snp.centerX)
            make.bottom.equalTo(itemsStackView.snp.top).offset(-45)
        }
        
        itemsStackView.snp.makeConstraints { make in
            make.centerX.equalTo(feedView.snp.centerX)
            make.centerY.equalTo(feedView.snp.centerY)
            make.width.equalTo(270)
            make.height.equalTo(220)
        }
    }
}


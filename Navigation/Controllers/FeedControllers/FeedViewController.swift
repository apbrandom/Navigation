//
//  ViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 26.12.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    weak var coordinator: FeedCoordinatable?
    private let viewModel = FeedViewModel()
    private let passwordCracking = PasswordCrack()
    private var passwordToCrack: String = ""
    private var timer: Timer?
    
    //MARK: - Subviews
    
    private lazy var feedView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont(name: "Courier", size: 25)
        label.textColor = UIColor.gray.withAlphaComponent(0.9)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        let button = VKStyleButton()
        button.setTitle("Check", for: .normal)
        return button
    }()
    
    private lazy var generateAndCrackButton: VKStyleButton = {
        let button = VKStyleButton()
        button.setTitle("Generate and Crack", for: .normal)
        button.pressed = { [self] in
            
            // Reset timer
            timer?.invalidate()
            timerLabel.text = "0"
            statusPasswordLabel.backgroundColor = .gray
            
            // Generate Random Password
            self.passwordToCrack = self.passwordCracking.generateRandomPassword(length: 4)
            passwordTextField.isSecureTextEntry = true
            passwordTextField.text = passwordToCrack
            activityIndicator.startAnimating()
            
            // Start timer
            var milliSecond = 0
            var second = 0
            timer = Timer(timeInterval: 0.01, repeats: true) { timer in
                milliSecond += 1
                if milliSecond == 100 {
                    second += 1
                    milliSecond = 0
                }
                DispatchQueue.main.async {
                    self.timerLabel.text = String(format: "%02d:%02d", second, milliSecond)
                }
            }
            
            RunLoop.current.add(timer!, forMode: .common)
            
            DispatchQueue.global().async { [weak self] in
                self?.passwordCracking.bruteForce(passwordToUnlock: self?.passwordToCrack ?? "")
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.passwordTextField.isSecureTextEntry = false
                    self?.statusPasswordLabel.backgroundColor = .green
                    self?.timerLabel.textColor = .red
                    self?.timer?.invalidate() // Stop timer
                }
            }
        }
        return button
    }()
    
    private lazy var postVCButton: VKStyleButton = {
        let button = VKStyleButton()
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
        feedView.addSubview(timerLabel)
        feedView.addSubview(itemsStackView)
        feedView.addSubview(statusPasswordLabel)
        feedView.addSubview(activityIndicator)
        itemsStackView.addArrangedSubview(passwordTextField)
        passwordTextField.addSubview(activityIndicator)
        itemsStackView.addArrangedSubview(checkButton)
        itemsStackView.addArrangedSubview(generateAndCrackButton)
        itemsStackView.addArrangedSubview(postVCButton)
    }
    
    //MARK: - Layout
    
    func setupConstrains() {
        feedView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.centerX.equalTo(feedView.snp.centerX)
            make.top.equalTo(statusPasswordLabel.snp.bottom).offset(20)
        }
        
        statusPasswordLabel.snp.makeConstraints { make in
            make.centerX.equalTo(feedView.snp.centerX)
            make.width.height.equalTo(50)
            make.top.equalTo(feedView.snp.top).offset(90)
        }
        
        itemsStackView.snp.makeConstraints { make in
            make.centerY.equalTo(feedView.snp.centerY)
            make.leading.trailing.equalTo(feedView).inset(16)
            make.height.equalTo(220)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(passwordTextField.snp.centerX)
            make.centerY.equalTo(passwordTextField.snp.centerY)
        }
    }
}


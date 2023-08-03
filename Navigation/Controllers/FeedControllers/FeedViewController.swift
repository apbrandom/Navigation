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
    
    //MARK: - Subviews
    
    private lazy var feedView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkModeBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        let text = NSLocalizedString("FeedVCTimerLabel", comment: "")
        label.text = "00:00"
        label.font = UIFont(name: text, size: 25)
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
        let text = "FeedVCTextField".localized
        textField.text = text
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray5
        return textField
    }()
    
    private lazy var checkButton: UIButton = {
        let button = VKStyleButton()
        let text = "FeedVCCheckButton".localized
        button.setTitle(text, for: .normal)
        return button
    }()
    
    private lazy var generateAndCrackButton: VKStyleButton = {
        let button = VKStyleButton()
        let text = "FeedVCGenerateAndCrackButton".localized
        button.setTitle(text, for: .normal)
        return button
    }()
    
    private lazy var postVCButton: VKStyleButton = {
        let button = VKStyleButton()
        let text = "FeedVCButtonPost".localized
        button.setTitle(text, for: .normal)
        button.pressed = { self.coordinator?.navigateToPostVC() }
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstrains()
        bindViewModel()
    }
    
    //MARK: - Private
    
    private func setupView() {
        view.backgroundColor = .darkModeBackground
        let text = "FeedVCNavigationItemTitle".localized
        navigationItem.title = text
    }
    
    private func bindViewModel() {
        viewModel.passwordUpdated = { [weak self] password in
            self?.passwordTextField.isSecureTextEntry = true
            self?.passwordTextField.text = password
        }
        
        viewModel.activityIndicatorState = { [weak self] isAnimating in
            if isAnimating {
                self?.activityIndicator.startAnimating()
            } else {
                self?.activityIndicator.stopAnimating()
            }
        }
        
        viewModel.passwordStatus = { [weak self] isCracked in
            self?.statusPasswordLabel.backgroundColor = isCracked ? .green : .gray
        }
        
        viewModel.timerUpdated = { [weak self] timeString in
            self?.timerLabel.text = timeString
        }
        
        generateAndCrackButton.pressed = { [weak self] in
            self?.viewModel.generateAndCrackPassword()
        }
    }
    
    //MARK: - Layout
    
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
    
    private func setupConstrains() {
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

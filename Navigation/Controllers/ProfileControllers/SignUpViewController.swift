//
//  SignUpViewController.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 20.06.2023.
//

import UIKit
import SnapKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    private let checkerService: CheckerServiceProtocol = CheckerService.shared
    
    //MARK: - Subviews
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var repeatPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Repeat Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var signUpButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Sign Up", for: .normal)
        button.pressed =  { self.registerButtonTapped() }
        return button
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        title = "Sign Up"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Actions
    
    private func registerButtonTapped() {
        guard let email = emailTextField.text,
              !email.isEmpty,
              let password = passwordTextField.text,
              !password.isEmpty,
              let repeatPassword = repeatPasswordTextField.text,
              !repeatPassword.isEmpty else {
            showAlert(
                title: "Error",
                message: "All fields must be filled out")
            return
        }
        guard password == repeatPassword else {
            showAlert(
                title: "Registration Error",
                message: "Passwords must be the same")
            return
        }
        
        // register a new user:
        checkerService.signUp(email: email, password: password) { [weak self] result in
            switch result {
            case .success(_):
                print("User signed up successfully")
                self?.navigationController?.popViewController(animated: true)
                self?.showAlert(
                    title: "Great!",
                    message: "You have successfully registered")
            case .failure(let error):
                print("Failed to sign up: ", error.localizedDescription)
                self?.showAlert(
                    title: "Registration error",
                    message: error.localizedDescription)
            }
        }
    }
    
    private func setupView() {
        navigationController?.isNavigationBarHidden = false
        title = "Sign Up"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        addSubviews()
    }
    
    private func addSubviews() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(repeatPasswordTextField)
        view.addSubview(signUpButton)
    }
    
    private func setupConstraints() {
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.leading.trailing.equalTo(view).inset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(emailTextField)
        }
        
        repeatPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(passwordTextField)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordTextField.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
    }
}


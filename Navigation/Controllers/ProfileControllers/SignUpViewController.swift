//
//  SignUpViewController.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 20.06.2023.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let repeatPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Repeat Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
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
    @objc private func signUpButtonTapped() {
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text,
            let repeatPassword = repeatPasswordTextField.text,
            password == repeatPassword // Проверка, что пароли совпадают
        else {
            // Обработка ошибок
            return
        }
        
        // Здесь вы можете реализовать логику регистрации
    }
    
    private func setupView() {
        navigationController?.isNavigationBarHidden = false
        title = "Sign Up"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
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


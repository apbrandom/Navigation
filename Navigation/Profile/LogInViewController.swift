//
//  LogInViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 04.02.2023.
//

import UIKit

class LogInViewController: UIViewController {
    
    private lazy var logInScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemBrown
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var logInView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var logInStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0.5
        stackView.backgroundColor = .lightGray
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.layer.masksToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.systemGray6
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .black
        textField.placeholder = "Email or phone"
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.systemGray6
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .black
        textField.placeholder = "Password"
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.autocapitalizationType = .none
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var logInButton: CustomButton = {
        let button = CustomButton()
        let image = UIImage(named: "blue_pixel")
        button.setBackgroundImage(image, for: .normal)
        button.setTitle("Log in", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(
            self,
            action: #selector(logInTapped),
            for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tuneView()
        addSubview()
        setupConstraint()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }
    
    //MARK: - Actions
    
    @objc func logInTapped() {
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    @objc func willShowKeyboard(_ notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        logInScrollView.contentInset.bottom += keyboardHeight ?? 0.0
    }
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        logInScrollView.contentInset.bottom = 0.0
    }
    
    //MARK: - Private
    
    private func tuneView() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubview() {
        view.addSubview(logInScrollView)
        logInScrollView.addSubview(logInView)
        logInView.addSubview(logoImageView)
        logInView.addSubview(logInStackView)
        logInStackView.addArrangedSubview(emailTextField)
        logInStackView.addArrangedSubview(passwordTextField)
        logInView.addSubview(logInButton)
    }
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            logInScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logInScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            logInScrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            logInScrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            logInView.topAnchor.constraint(equalTo: logInScrollView.topAnchor),
            logInView.bottomAnchor.constraint(equalTo: logInScrollView.bottomAnchor),
            logInView.leftAnchor.constraint(equalTo: logInScrollView.leftAnchor),
            logInView.rightAnchor.constraint(equalTo: logInScrollView.rightAnchor),
            logInView.heightAnchor.constraint(equalTo: logInScrollView.heightAnchor),
            logInView.widthAnchor.constraint(equalTo: logInScrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: logInView.topAnchor, constant: 120),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: logInView.centerXAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            logInStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            logInStackView.heightAnchor.constraint(equalToConstant: 100),
            logInStackView.leadingAnchor.constraint(equalTo: logInView.leadingAnchor, constant: 16),
            logInStackView.trailingAnchor.constraint(equalTo: logInView.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            logInButton.topAnchor.constraint(equalTo: logInStackView.bottomAnchor, constant: 16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.leadingAnchor.constraint(equalTo: logInView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: logInView.trailingAnchor, constant: -16)
        ])
    }
    
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}


//
//  LogInViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 04.02.2023.
//

import UIKit
import SnapKit
import FirebaseAuth

protocol LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool
}

class LoginViewController: UIViewController {
    
    var loginDelegate: LoginViewControllerDelegate?
    var userService: UserService
    var keyboardManager: KeyboardManager?
    weak var coordinator: ProfileCoordinatable?
    
    init(userService: UserService, loginInspector: LoginInspector) {
        self.userService = userService
        self.loginDelegate = loginInspector
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Subviews
    
    private lazy var loginScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var loginStackView: UIStackView = {
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
    
    private lazy var loginTextField: CustomTextField = { [unowned self] in
        let textField = CustomTextField()
        textField.text = "user"
        textField.placeholder = "Email or phone"
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordTextField: CustomTextField = { [unowned self] in
        let textField = CustomTextField()
        textField.placeholder = "Password"
        textField.text = "password"
        textField.isSecureTextEntry = true
        textField.delegate = self
        return textField
    }()
    
    private lazy var signInButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Sign In", for: .normal)
        button.pressed = { self.signInButtonTapped() }
        return button
    }()
    
    private lazy var signUpButton: CustomButton = {
        let button = CustomButton()
        button.setBackgroundImage(.none, for: .normal)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.pressed = { self.signUpButtonTapped() }
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubview()
        setupConstraints()
    }
    
    //MARK: - Actions
    
    @objc private func signInButtonTapped() {
        guard let login = loginTextField.text,
              let password = passwordTextField.text
        else { return }
        coordinator?.loginWith(login, password)
    }
    
    @objc private func signUpButtonTapped() {
        
        
//        guard let email = loginTextField.text,
//              let password = passwordTextField.text
//        else { return }
//
//        Auth.auth().createUser(withEmail: email, password: password) {
//            authResult, error in
//            if let error = error {
//                print("Failed to sign up: ", error.localizedDescription)
//                return
//            }
//            print("User signed successfully")
//        }
    }
    
    //MARK: - Private
    
    private func setupView() {
        title = "Profile"
        view.backgroundColor = .secondarySystemBackground
        
        tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            tag: 0
        )
        
        keyboardManager = KeyboardManager(scrollView: loginScrollView)
    }
    
    private func setupSubview() {
        view.addSubview(loginScrollView)
        loginScrollView.addSubview(contentView)
        contentView.addSubview(logoImageView)
        contentView.addSubview(loginStackView)
        loginStackView.addArrangedSubview(loginTextField)
        loginStackView.addArrangedSubview(passwordTextField)
        contentView.addSubview(signInButton)
        contentView.addSubview(signUpButton)
    }
 
    //MARK: - Layout
    
    private func setupConstraints() {
        loginScrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(loginScrollView)
            make.width.equalTo(loginScrollView)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(120)
            make.height.width.equalTo(100)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        loginStackView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(120)
            make.height.equalTo(100)
            make.leading.trailing.equalTo(contentView).inset(16)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(loginStackView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(contentView).inset(16)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(16)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(100)
//            make.leading.trailing.equalTo(contentView).inset(16)
//            make.height.equalTo(50)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }
    }
}

//MARK: - Delegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


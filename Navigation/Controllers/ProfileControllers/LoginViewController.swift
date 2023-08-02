//
//  LogInViewController.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 04.02.2023.
//

import UIKit
import SnapKit
import FirebaseAuth

protocol LoginViewControllerDelegate: AnyObject {
    func checkCredentials(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void)
    func signUp(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void)
}

class LoginViewController: UIViewController {
    
    private var delegate: LoginViewControllerDelegate?
    var userService: UserService
    var keyboardManager: KeyboardManager?
    weak var coordinator: ProfileCoordinatable?
    
    init(userService: UserService, loginInspector: LoginInspector) {
        self.userService = userService
        self.delegate = loginInspector
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Subviews
    
    private lazy var loginScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .darkModeBackground
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkModeBackground
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
        textField.text = "user@mail.com"
        let text = NSLocalizedString("AuthorizationVCLoginTextField", comment: "")
        textField.placeholder = text
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordTextField: CustomTextField = { [unowned self] in
        let textField = CustomTextField()
        let text = NSLocalizedString("AuthorizationVCPasswordTextField", comment: "")
        textField.placeholder = text
        textField.text = "password"
        textField.isSecureTextEntry = true
        textField.delegate = self
        return textField
    }()
    
    private lazy var signInButton: VKStyleButton = {
        let button = VKStyleButton()
        let text = NSLocalizedString("AuthorizationVCSignInButton", comment: "")
        button.setTitle(text, for: .normal)
        button.pressed = { self.signInButtonTapped() }
        return button
    }()
    
    private lazy var signUpButton: VKStyleButton = {
        let button = VKStyleButton()
        button.setBackgroundImage(.none, for: .normal)
        let text = NSLocalizedString("AuthorizationVCSignUpButton", comment: "")
        button.setTitle(text, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.5
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
    
    private func signInButtonTapped() {
        guard let email = loginTextField.text,
              let password = passwordTextField.text else {
            preconditionFailure("Form must not be empty")
        }

        delegate?.checkCredentials(email: email, password: password) { [weak self] result in
            switch result {
                
            case .success(let authResult):
                print("User \(authResult.user.uid) signed in successfully")
                self?.coordinator?.loginWith(email, password)
            
            case .failure(let error):
                print("Failed to sign in: ", error.localizedDescription)
                self?.showAlert(
                    title: "Login Failed",
                    message: "Invalid username or password. Please try again")
            }
        }
    }
    
    private func signUpButtonTapped() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    //MARK: - Private
    
    private func setupView() {
        view.backgroundColor = .darkModeBackground
        let text = "LoginVCNavigationTitle".localized
        navigationItem.title = text
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
            make.width.equalTo(140)
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


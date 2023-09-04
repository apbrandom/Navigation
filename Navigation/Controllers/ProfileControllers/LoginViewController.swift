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
    private let biometricAuthService = LocalAuthorizationService()
    private var loginManager: LoginManager
    
    init(userService: UserService, loginInspector: LoginViewControllerDelegate) {
            self.userService = userService
            self.delegate = loginInspector
            self.loginManager = LoginManager(
                checkerService: CheckerService.shared,
                keychainService: KeychainService.shared,
                realmService: RealmService.shared
            )
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
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [signInButton, biometricAuthButton, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    private lazy var signInButton: VKStyleButton = {
        let button = VKStyleButton()
        let text = NSLocalizedString("AuthorizationVCSignInButton", comment: "")
        button.setTitle(text, for: .normal)
        button.pressed = { self.signInButtonTapped() }
        button.translatesAutoresizingMaskIntoConstraints = false
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
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var biometricAuthButton: VKStyleButton = {
        let button = VKStyleButton()
        let text = NSLocalizedString("BiometricAuthButton", comment: "")
        button.setTitle(text, for: .normal)
        button.backgroundColor = .systemBlue
        button.pressed = { self.handleBiometricAuthButton() }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubview()
        setupConstraints()
        setupBiometricType()
    }
    
    //MARK: - Actions
    
    internal func signInButtonTapped() {
        guard let email = loginTextField.text, let password = passwordTextField.text else {
            preconditionFailure("Form must not be empty")
        }
        
        loginManager.handleSignIn(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let authResult):
                print("User \(authResult.user.uid) signed in successfully")
                self?.coordinator?.loginWith(email, password)
            case .failure(let error):
                print("Failed to sign in: ", error.localizedDescription)
                self?.showAlert(title: "Login Failed", message: "Invalid username or password. Please try again")
            }
        }
        
    }
    
    @objc private func handleBiometricAuthButton() {
        biometricAuthService.authorizeIfPossible { [weak self] (success, error) in
            if success {
                // Здесь мы пытаемся получить учетные данные из Keychain
                if let savedCredentials = KeychainService.shared.getCredentials() {
                    let email = savedCredentials.email
                    let password = savedCredentials.password
                    
                    // Теперь используем эти учетные данные для аутентификации
                    self?.delegate?.checkCredentials(email: email, password: password) { result in
                        switch result {
                        case .success(let authResult):
                            print("User \(authResult.user.uid) signed in successfully with biometrics")
                            self?.coordinator?.loginWith(email, password)
                        case .failure(let error):
                            print("Failed to sign in with saved credentials: ", error.localizedDescription)
                            self?.showAlert(title: "Login Failed", message: "Could not sign in with saved credentials. Please log in manually.")
                        }
                    }
                } else {
                    print("No saved credentials found")
                    self?.showAlert(title: "Login Failed", message: "No saved credentials found. Please log in manually.")
                }
            } else if let error = error {
                self?.showAlert(title: "Authentication Failed", message: error.localizedDescription)
            }
        }
    }

    internal func signUpButtonTapped() {
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
        contentView.addSubview(buttonsStackView)
    }
    
    
    private func setupBiometricType() {
        print("Checking credentials from KeychainService...")
        guard let credentials = KeychainService.shared.getCredentials() else {
            print("No saved credentials found")
            biometricAuthButton.isHidden = true
            return
        }
        print("Credentials found!")
        
        let email = credentials.email
        
        if RealmService.shared.retrieveUser(email: email) == nil {
            print("No saved credentials found in Realm")
            biometricAuthButton.isHidden = true
            return
        }
        
        print("Saved credentials found for email: \(email)")
        
        let biometricType = biometricAuthService.availableBiometryType
        print("Available biometric type: \(biometricType)")
        switch biometricType {
        case .faceID:
            biometricAuthButton.setTitle("Face Id", for: .normal)
            biometricAuthButton.isHidden = false
        case .touchID:
            biometricAuthButton.setTitle("Touch Id", for: .normal)
            biometricAuthButton.isHidden = false
        case .none:
            biometricAuthButton.isHidden = false
        case .opticID:
            biometricAuthButton.isHidden = false
        @unknown default:
            biometricAuthButton.isEnabled = false
        }
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
        
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(loginStackView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(contentView).inset(16)
        }
        
        signInButton.snp.makeConstraints { make in
            make.height.lessThanOrEqualTo(50)
        }
        
        biometricAuthButton.snp.makeConstraints { make in
            make.height.lessThanOrEqualTo(50)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.lessThanOrEqualTo(50)
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

//
//  LogInViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 04.02.2023.
//

import UIKit
import SnapKit

class LogInViewController: UIViewController {
    
    var userService: UserService
    
    init() {
#if DEBUG
        userService = TestUserService()
#else
        userService = CurrentUserService()
#endif
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Subviews
    
    private lazy var logInScrollView: UIScrollView = {
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
    
    private lazy var loginField: UITextField = { [unowned self] in
        let textField = UITextField()
        textField.backgroundColor = UIColor.systemGray6
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .black
        textField.placeholder = "Email or phone"
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordField: UITextField = { [unowned self] in
        let textField = UITextField()
        textField.backgroundColor = UIColor.systemGray6
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .black
        textField.placeholder = "Password"
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
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
        button.addTarget(
            self,
            action: #selector(logInTapped),
            for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubview()
        setupConstraints()
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
        if let user = userService.checkLogin(login: loginField.text ?? "", password: passwordField.text ?? "") {
            let profileVC = ProfileViewController(user: user)
            navigationController?.setViewControllers([profileVC], animated: true)
        } else {
            let alert = UIAlertController(title: "Unknown login", message: "Please, enter correct user login and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(alert, animated: true)
        }
    }
    // Show error if login is empty
    //        guard let login = loginTextField.text, !login.isEmpty else {
    //            let alertController = UIAlertController(
    //                title: nil,
    //                message: "Please, enter your login" ,
    //                preferredStyle: .alert
    //            )
    //
    //            let action = UIAlertAction(title: "OK", style: .default)
    //            alertController.addAction(action)
    //            present(alertController, animated: true)
    //            return
    //        }
    //
    //        // Found user, navigate to ProfileViewController
    //        if let user = currentUserService.getUser(login: login) {
    //            let profileVC = ProfileViewController()
    //            profileVC.user = user
    //
    //            navigationController?.pushViewController(profileVC, animated: true)
    //        } else {
    //
    //            // Show error if user not found
    //            let alertController = UIAlertController(
    //                title: nil,
    //                message: "User not found",
    //                preferredStyle: .alert
    //            )
    //            let action = UIAlertAction(title: "OK", style: .default)
    //            alertController.addAction(action)
    //            present(alertController, animated: true)
    //            print("User no found")
    //        }
    //}
    
    
    @objc func willShowKeyboard(_ notification: NSNotification) {
        if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardFrame.height
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            
            logInScrollView.contentInset = contentInsets
            logInScrollView.scrollIndicatorInsets = contentInsets
            logInScrollView.scrollRectToVisible(logInButton.frame, animated: true)
        }
    }
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        
        logInScrollView.contentInset = contentInsets
        logInScrollView.scrollIndicatorInsets = contentInsets
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
    }
    
    private func setupSubview() {
        view.addSubview(logInScrollView)
        logInScrollView.addSubview(contentView)
        contentView.addSubview(logoImageView)
        contentView.addSubview(logInStackView)
        logInStackView.addArrangedSubview(loginField)
        logInStackView.addArrangedSubview(passwordField)
        contentView.addSubview(logInButton)
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
    
    //MARK: - Layout
    
    private func setupConstraints() {
        logInScrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(logInScrollView)
            make.width.equalTo(logInScrollView)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(120)
            make.height.width.equalTo(100)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        logInStackView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(120)
            make.height.equalTo(100)
            make.leading.trailing.equalTo(contentView).inset(16)
        }
        
        
        logInButton.snp.makeConstraints { make in
            make.top.equalTo(logInStackView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(50)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }
        
    }
}

//MARK: - Delegate

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}


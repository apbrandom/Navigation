//
//  ProfileHeaderView2.swift
//  Navigation
//
//  Created by Вадим Виноградов on 16.01.2023.
//

import UIKit
import SnapKit

class ProfileTableHeaderView: UIView {
    
    private var statusText = ""
    private var avatarCenterOrigin: CGPoint = .zero
    weak var delegate: ProfileTableHeaderViewDelegate?
    
    //MARK: - Subviews
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = 60
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.systemBackground.cgColor
        imageView.layer.borderWidth = 3
        
        let imageTap = UITapGestureRecognizer(
            target: self,
            action: #selector(didAvatarImageTaped))
        imageView.addGestureRecognizer(imageTap)
        return imageView
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .white
        button.alpha = 0
        button.addTarget(
            self,
            action: #selector(didCloseButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.masksToBounds = true
        textField.layer.backgroundColor = UIColor.systemBackground.cgColor
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 12
        textField.layer.backgroundColor = UIColor.systemBackground.cgColor
        let text = "ProfileTableHeaderViewStatusTextField".localized
        textField.placeholder = text
        textField.addTarget(
            self,
            action: #selector(statusTextChanged),
            for: .editingChanged)
        textField.delegate = self
        return textField
    }()
    
    lazy var setStatusButton: VKStyleButton = {
        let button = VKStyleButton()
        let text = NSLocalizedString("ProfileTableHeaderViewSetStatusButton", comment: "")
        button.setTitle(text, for: .normal)
        button.addTarget(
            self,
            action: #selector(setButtonPressed),
            for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupConstarins()
        showSemiTransparentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Action
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        if let text = statusTextField.text {
            statusText = text
        }
    }
    
    @objc private func setButtonPressed(_ textField: UITextField) {
        statusLabel.text = statusText
        statusTextField.text = ""
    }
    
    @objc private func didAvatarImageTaped() {
        avatarCenterOrigin = avatarImageView.center
        
        let screenWidth = UIScreen.main.bounds.width
        
        UIView.animateKeyframes(
            withDuration: 0.5,
            delay: 0.0,
            options: .calculationModeCubic,
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 0.5
                ) {
                    self.avatarImageView.center = CGPoint(
                        x: UIScreen.main.bounds.midX,
                        y: UIScreen.main.bounds.midY / 1.2
                    )
                    self.avatarImageView.layer.cornerRadius = 0
                    self.avatarImageView.layer.borderWidth = 0
                }
                UIView.addKeyframe(
                    withRelativeStartTime: 0.5,
                    relativeDuration: 0.5
                ) {
                    self.avatarImageView.transform = CGAffineTransform(
                        scaleX: screenWidth/self.avatarImageView.frame.size.width,
                        y: screenWidth/self.avatarImageView.frame.size.height
                    )
                    self.showSemiTransparentView()
                    self.closeButton.alpha = 1.0
                }
                
            })
    }
    
    @objc func didCloseButtonTapped(_ centerOrigin: CGPoint) {
        UIView.animateKeyframes(
            withDuration: 0.5,
            delay: 0.0,
            options: .calculationModeCubic,
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 1.0
                ) {
                    self.avatarImageView.center = self.avatarCenterOrigin
                    self.avatarImageView.transform = .identity
                    self.avatarImageView.layer.cornerRadius = 60
                    self.closeButton.alpha = 0
                    self.avatarImageView.layer.borderWidth = 3
                    self.hideSemiTransparentView()
                }
            })
    }
    
    //MARK: - Private
    
    private func setupSubviews() {
        addSubview(setStatusButton)
        addSubview(infoStackView)
        infoStackView.addArrangedSubview(fullNameLabel)
        infoStackView.addArrangedSubview(statusLabel)
        infoStackView.addArrangedSubview(statusTextField)
        addSubview(avatarImageView)
        addSubview(closeButton)
    }
    
    // MARK: - Layout
    
    override var intrinsicContentSize: CGSize {
        CGSize(
            width: UIView.noIntrinsicMetric,
            height: 220.0
        )
    }
    
    private func setupConstarins() {
        avatarImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(120)
        }
        
        setStatusButton.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.bottom.equalTo(setStatusButton.snp.top).offset(-16)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        statusTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func updateUser(_ user: User) {
        avatarImageView.image = user.avatar
        fullNameLabel.text = user.fullName
        statusLabel.text = user.status
    }
    
    private func showSemiTransparentView() {
        delegate?.showSemiTransparentView()
    }
    
    private func hideSemiTransparentView() {
        delegate?.hideSemiTransparentView()
    }
}

//MARK: - UITextFieldDeligate

extension ProfileTableHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        statusTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if statusTextField.text != "" {
            statusLabel.text = statusTextField.text
        }
        statusTextField.text = ""
    }
}
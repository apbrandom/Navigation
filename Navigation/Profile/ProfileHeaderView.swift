//
//  ProfileHeaderView2.swift
//  Navigation
//
//  Created by Вадим Виноградов on 16.01.2023.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private lazy var avatarImageView: UIImageView = {
        var imageView = UIImageView()
        imageView = UIImageView(frame: CGRect(x: 16, y: 16, width: 100, height: 100))
        imageView.layer.contents = UIImage(named: "cat")?.cgImage
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.systemBackground.cgColor
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Cat Traveler"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Looking for a new location..."
        label.textColor = UIColor.systemGray
        return label
    }()
    
    lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()
    
    lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.backgroundColor = .systemBlue
        button.setTitle("Show Status", for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSelf()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    }
    
    private func setupSelf() {
        
        addSubview(avatarImageView)
        addSubview(setStatusButton)
        addSubview(infoStackView)
        infoStackView.addArrangedSubview(fullNameLabel)
        infoStackView.addArrangedSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 16
            ),
            avatarImageView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            ),
            avatarImageView.widthAnchor.constraint(
                equalToConstant: 100
            ),
            avatarImageView.heightAnchor.constraint(
                equalTo: avatarImageView.widthAnchor,
                multiplier: 1.0
            ),
            
            setStatusButton.topAnchor.constraint(
                equalTo: avatarImageView.bottomAnchor,
                constant: 16
            ),
            setStatusButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            ),
            setStatusButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            ),
            setStatusButton.heightAnchor.constraint(
                equalToConstant: 50
            ),
            
            infoStackView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 27
            ),
            infoStackView.bottomAnchor.constraint(
                equalTo: setStatusButton.topAnchor,
                constant: -34
            ),
            infoStackView.leftAnchor.constraint(
                equalTo: avatarImageView.rightAnchor,
                constant: 16
            ),
            infoStackView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            )
            
            
                                    ])
    }
    
 
    
}



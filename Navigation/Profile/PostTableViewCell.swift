//
//  ProfileTableViewCell.swift
//  Navigation
//
//  Created by Вадим Виноградов on 17.02.2023.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    static let indentifire = "CustomCell"
    
    //MARK: - Subviews
    
    private let postTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "quistionmark")
        imageView.tintColor = .label
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var postAuthorTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 14)
        textView.textColor = .systemGray
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var postLikesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.tintColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var postViewsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.tintColor = .black
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview()
        setupConstrant()
    }
    
    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private
    
    private func addSubview() {
        contentView.addSubview(postTitleLabel)
        contentView.addSubview(postImageView)
        contentView.addSubview(postAuthorTextView)
        contentView.addSubview(postLikesLabel)
        contentView.addSubview(postViewsLabel)
    }
    
    //MARK: - Public
    
    func update(_ model: Post) {
        postTitleLabel.text = model.title
        postAuthorTextView.text = model.author
        postImageView.image = UIImage(named: model.image)
        postLikesLabel.text = "Likes: \(model.likes)"
        postViewsLabel.text = "Views: \(model.views)"
    }
    
    //MARK: - Layout
    
    private func setupConstrant() {
        NSLayoutConstraint.activate([
            postTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            postTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            postAuthorTextView.topAnchor.constraint(equalTo: postImageView.bottomAnchor),
            postAuthorTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postAuthorTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            postLikesLabel.topAnchor.constraint(equalTo: postAuthorTextView.bottomAnchor),
            postLikesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postLikesLabel.trailingAnchor.constraint(equalTo: postViewsLabel.leadingAnchor),
            postLikesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            postViewsLabel.topAnchor.constraint(equalTo: postAuthorTextView.bottomAnchor),
            postViewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postViewsLabel.leadingAnchor.constraint(equalTo: postLikesLabel.trailingAnchor),
            postViewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}

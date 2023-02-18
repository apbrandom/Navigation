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
    
    private let postLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "quistionmark")
        imageView.tintColor = .label
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
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
        contentView.addSubview(postLabel)
        contentView.addSubview(postImageView)
    }
    
    //MARK: - Public
    //
    //     func configure(with image: UIImage) {
    //        postImageView.image = image
    //        mylabel.text = label
    //    }
    //
    func update(_ model: Post) {
        postLabel.text = model.title
        postImageView.image = UIImage(named: model.image)
    }
    
    private func setupConstrant() {
        
        NSLayoutConstraint.activate([
            postLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            postLabel.heightAnchor.constraint(equalToConstant: 25),
            postLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: postLabel.bottomAnchor),
            postImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
        ])
    }
    
    
}

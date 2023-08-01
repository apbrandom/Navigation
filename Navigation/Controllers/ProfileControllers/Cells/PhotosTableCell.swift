//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Вадим Виноградов on 21.02.2023.
//

import UIKit

class PhotosTableCell: UITableViewCell {
    
    static let indentifire = "CustomCell2"
    
    //MARK: - Subviews
    
    private lazy var photoLabel: UILabel = {
        let label = UILabel()
        let text = NSLocalizedString("PhotosTableCellPhotoLabel", comment: "")
        label.text = text
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var arrowImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.right"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var photoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .systemBackground
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var firstImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemYellow
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var secondImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemOrange
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var thirdImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemRed
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var fourthImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPurple
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        setupConstraints()
    }
    
    required init? (coder: NSCoder) {
        fatalError("init\(coder): has not been implemented")
    }
    
    //MARK: - Private
    
    private func setupSubviews() {
        contentView.addSubview(photoLabel)
        contentView.addSubview(arrowImage)
        contentView.addSubview(photoStackView)
        photoStackView.addArrangedSubview(firstImageView)
        photoStackView.addArrangedSubview(secondImageView)
        photoStackView.addArrangedSubview(thirdImageView)
        photoStackView.addArrangedSubview(fourthImageView)
    }
    
    //MARK: - Public
    
    func update(_ models: [UIImage?]) {
        if let firstImage = models[0] {
            firstImageView.image = firstImage
        }
        if let secondImage = models[1] {
            secondImageView.image = secondImage
        }
        if let thirdImage = models[2] {
            thirdImageView.image = thirdImage
        }
        if let fourthImage = models[3] {
            fourthImageView.image = fourthImage
        }
    }
    
    //MARK: - Layout
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            photoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photoLabel.trailingAnchor.constraint(equalTo: arrowImage.leadingAnchor),
            
            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrowImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            
            photoStackView.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: 12),
            photoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            photoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            photoStackView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}

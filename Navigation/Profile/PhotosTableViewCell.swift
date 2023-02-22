//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Вадим Виноградов on 21.02.2023.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    static let indentifire = "CustomCell2"
    
    //MARK: - Subviews
    
    private lazy var photoLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var arrowImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.right"))
//        image.backgroundColor = UIColor.systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var photoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .systemBlue
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
            
        addSubviews()
        setupConstraints()
    }
    
    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private
    
    private func addSubviews() {
        contentView.addSubview(photoLabel)
        contentView.addSubview(arrowImage)
        contentView.addSubview(photoStackView)
        photoStackView.addArrangedSubview(firstImageView)
        photoStackView.addArrangedSubview(secondImageView)
        photoStackView.addArrangedSubview(thirdImageView)
        photoStackView.addArrangedSubview(fourthImageView)
    }
    
    //MARK: - Action
    
    func update(_ model: Photo?) {
        guard let photo = model else {
            return
        }
        firstImageView.image = UIImage(named: photo.name)
        secondImageView.image = UIImage(named: photo.name)
        thirdImageView.image = UIImage(named: photo.name)
        fourthImageView.image = UIImage(named: photo.name)
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

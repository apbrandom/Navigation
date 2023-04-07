//
//  PhotoCollectionViewCell.swift
//  Navigation
//
//  Created by Вадим Виноградов on 22.02.2023.
//

import UIKit

class PhotosCollectionCell: UICollectionViewCell {
    
    //MARK: - Subviews
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupSubviews()
        setupLayouts()
    }
    
    //MARK: - Private
    
    func setupSubviews() {
        contentView.addSubview(photoImageView)
    }
    
    //MARK: - Public
    
    func update(_ models: Photo?) {
        guard let photos = models else {
            return
        }
        photoImageView.image = UIImage(named: photos.image)
    }
    
    //MARK: - Layout
    
    func setupLayouts() {
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}

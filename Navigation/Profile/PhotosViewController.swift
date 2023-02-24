//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 21.02.2023.
//

import UIKit

class PhotosViewController: UIViewController {
    
    //MARK: - Data
    
    let photoData = Photo.make()
    
    //MARK: - Subviews
    
    private lazy var photoCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .vertical
        viewLayout.minimumInteritemSpacing = LayoutConstant.spacing
        viewLayout.minimumLineSpacing = LayoutConstant.spacing
        viewLayout.sectionInset = UIEdgeInsets(
            top: LayoutConstant.spacing,
            left: LayoutConstant.spacing,
            bottom: LayoutConstant.spacing,
            right: LayoutConstant.spacing
        )
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: viewLayout
        )
        
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            PhotosCollectionCell.self,
            forCellWithReuseIdentifier: PhotosCollectionCell.identifier)
        return collectionView
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupCollectionView()
        setupLayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    //MARK: - Private
    
    private func setupView() {
        navigationItem.title = "Photo Gallery"
        view.backgroundColor = .systemBackground
    }
    
    private func setupCollectionView() {
        view.addSubview(photoCollectionView)
        
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
    }
    
    private enum LayoutConstant {
        static let spacing: CGFloat = 8.0
    }
    
    //MARK: - layout
    
    private func setupLayouts() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            photoCollectionView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            photoCollectionView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            photoCollectionView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            photoCollectionView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor)
        ])
    }
    
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionCell.identifier, for: indexPath) as! PhotosCollectionCell
        let photo = photoData[indexPath.item]
        cell.update(photo)
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 4 * LayoutConstant.spacing) / 3
        return CGSize(width: width, height: width)
    }
    
}

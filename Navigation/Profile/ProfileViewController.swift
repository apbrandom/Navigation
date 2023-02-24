//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 04.01.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: - Data
    
    fileprivate let postData = Post.make()
    fileprivate let photoData = Photo.make()
    
    
    //MARK: - Subviews
    
    private lazy var profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.secondarySystemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubviews()
        setupTableView()
        setupConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - Privte
    
    private func setupView() {
        navigationItem.title = "Profile"
        view.backgroundColor = .systemBackground
    }
    
    private func setupSubviews() {
        view.addSubview(profileTableView)
    }
    
    private func setupTableView() {
        profileTableView.rowHeight = UITableView.automaticDimension
        profileTableView.estimatedRowHeight = 500
        
        
        let headerView = ProfileTableHeaderView()
        profileTableView.setAndLayout(headerView: headerView)
        profileTableView.register(PostsTableCell.self, forCellReuseIdentifier: PostsTableCell.indentifire)
        profileTableView.register(PhotosTableCell.self, forCellReuseIdentifier: PhotosTableCell.indentifire )
        
        profileTableView.dataSource = self
        profileTableView.delegate = self
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            profileTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            profileTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}

//MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return postData.count
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if postData.count > 0 {
            if indexPath.section == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableCell.indentifire, for: indexPath) as? PhotosTableCell else {
                    fatalError("could not dequeueReusableCell")
                }
                cell.update(photoData)
                cell.selectionStyle = .none
                cell.tintColor = .black
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PostsTableCell.indentifire, for: indexPath) as? PostsTableCell else {
                    fatalError("could not dequeueReusableCell")
                }
                cell.update(postData[indexPath.row])
                cell.selectionStyle = .none
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            navigationController?.pushViewController(PhotosViewController(), animated: true)
        }
        
    }
    
}

extension ProfileViewController: UITableViewDelegate {}

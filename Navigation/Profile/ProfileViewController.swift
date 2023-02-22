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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var newButton: UIButton = {
        let button = UIButton()
        button.setTitle("New Button", for: .normal)
        button.backgroundColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tuneView()
        addSubviews()
        setupConstrains()
        tuneTableView()
    }
    
    //MARK: - Privte
    
    private func tuneView() {
        navigationItem.title = "Profile"
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(profileTableView)
        view.addSubview(newButton)
    }
    
    private func tuneTableView() {
        profileTableView.rowHeight = UITableView.automaticDimension
        profileTableView.estimatedRowHeight = 500
        profileTableView.backgroundColor = UIColor.secondarySystemBackground
        
        let headerView = ProfileTableHeaderView()
        profileTableView.setAndLayout(headerView: headerView)
        profileTableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.indentifire)
        profileTableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.indentifire )
        
        profileTableView.dataSource = self
        profileTableView.delegate = self
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            profileTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            profileTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            newButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            newButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            newButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            newButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}

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
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.indentifire, for: indexPath) as? PhotosTableViewCell else {
                    fatalError("could not dequeueReusableCell")
                }
                
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.indentifire, for: indexPath) as? PostTableViewCell else {
                    fatalError("could not dequeueReusableCell")
                }
                cell.update(postData[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
    
}
extension ProfileViewController: UITableViewDelegate {}

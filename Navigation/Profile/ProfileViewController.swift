//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 04.01.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: - Data
    
    fileprivate let data = Post.make()
    
    //MARK: - Subviews
    
    private lazy var profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //    private lazy var newButton: UIButton = {
    //        let button = UIButton()
    //        button.setTitle("New Button", for: .normal)
    //        button.backgroundColor = UIColor.red
    //        button.translatesAutoresizingMaskIntoConstraints = false
    //        return button
    //    }()
    
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
        //        view.addSubview(newButton)
    }
    
    private func tuneTableView() {
        profileTableView.rowHeight = UITableView.automaticDimension
        profileTableView.estimatedRowHeight = 250
        profileTableView.backgroundColor = UIColor.secondarySystemBackground
        
        let headerView = ProfileTableHeaderView()
        profileTableView.setAndLayout(headerView: headerView)
        profileTableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.indentifire)
        profileTableView.dataSource = self
        profileTableView.delegate = self
    }
    
    private func setupConstrains() {

        NSLayoutConstraint.activate([
            profileTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            profileTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        //
        //            newButton.leftAnchor.constraint(equalTo: view.leftAnchor),
        //            newButton.rightAnchor.constraint(equalTo: view.rightAnchor),
        //            newButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        //            newButton.heightAnchor.constraint(equalToConstant: 50)
        //        ])
        
    }
    
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.indentifire, for: indexPath) as? PostTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        
        cell.update(data[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250
    }
    
    
}

extension ProfileViewController: UITableViewDelegate {}

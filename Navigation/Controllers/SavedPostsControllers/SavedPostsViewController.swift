//
//  FavouriteViewController.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 25.07.2023.
//

import UIKit
import SnapKit

class SavedPostsViewController: UIViewController {
    
    weak var coordinator: SavedPostsCoordinatable?
    var viewModel = FavouritesViewModel()
    
    lazy var favouriteTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.secondarySystemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    deinit {
        coordinator?.finish()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        layoutTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.favouriteTableView.reloadData()
        }
    }
    
    private func setupTableView() {
        favouriteTableView.delegate = self
        favouriteTableView.dataSource = self
        favouriteTableView.register(PostsTableCell.self, forCellReuseIdentifier: PostsTableCell.indentifire)
    }
    
    private func layoutTableView() {
        view.addSubview(favouriteTableView)
        favouriteTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        let text = NSLocalizedString("SavedPostsVCNavigationItemTitle", comment: "")
        navigationItem.title = text
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}


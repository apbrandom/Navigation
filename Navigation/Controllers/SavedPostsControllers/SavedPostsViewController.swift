//
//  FavouriteViewController.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 25.07.2023.
//

import UIKit
import SnapKit
import CoreData

class SavedPostsViewController: UIViewController {
    
    weak var coordinator: SavedPostsCoordinatable?
    var viewModel = FavouritesViewModel()
    var fetchedResultsController: NSFetchedResultsController<CDPostItem>!
    
    lazy var favouriteTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.secondarySystemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var searchButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass.circle"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(searchButtonTapped))
        return button
    }()
    
    lazy var clearButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(clearButtonTapped))
        return button
    }()
    
    deinit {
        coordinator?.finish()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        layoutTableView()
        setupFetchedResultsController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.favouriteTableView.reloadData()
        }
    }
    
    //MARK: - Actions
    
    @objc func searchButtonTapped() {
        let alert = UIAlertController(title: "Поиск", message: "Введите имя автора", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Имя автора"
        }
        alert.addAction(UIAlertAction(title: "Применить", style: .default, handler: { _ in
            if let textField = alert.textFields?.first, let text = textField.text {
                self.filterByAuthor(author: text)
            }
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func clearButtonTapped() {
        clearFilter()
    }
    
    func filterByAuthor(author: String) {
        let fetchRequest: NSFetchRequest<CDPostItem> = CDPostItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "author CONTAINS %@", author)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        updateFetchedResultsController(fetchRequest: fetchRequest)
    }
    
    func clearFilter() {
        let fetchRequest: NSFetchRequest<CDPostItem> = CDPostItem.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        updateFetchedResultsController(fetchRequest: fetchRequest)
    }
    
    func updateFetchedResultsController(fetchRequest: NSFetchRequest<CDPostItem>) {
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: CoreDataStorageService.shared.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            favouriteTableView.reloadData()
        } catch {
            print("Failed to fetch items: \(error)")
        }
    }
    
    //MARK: - Private
    
    private func setupTableView() {
        favouriteTableView.delegate = self
        favouriteTableView.dataSource = self
        favouriteTableView.register(PostsTableCell.self, forCellReuseIdentifier: PostsTableCell.indentifire)
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        let text = NSLocalizedString("SavedPostsVCNavigationItemTitle", comment: "")
        navigationItem.title = text
        navigationItem.rightBarButtonItems = [clearButton, searchButton]
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupFetchedResultsController() {
        let fetchRequest: NSFetchRequest<CDPostItem> = CDPostItem.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: CoreDataStorageService.shared.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Failed to fetch items: \(error)")
        }
    }
    
    private func layoutTableView() {
        view.addSubview(favouriteTableView)
        favouriteTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
}


//
//  FavouriteViewController+TableView.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 28.07.2023.
//

import UIKit
import CoreData

extension SavedPostsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { (action, view, completion) in
            if let post = self.fetchedResultsController.fetchedObjects?[indexPath.row] {
                self.viewModel.deletePost(post, in: self.fetchedResultsController.managedObjectContext)
            }
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostsTableCell.indentifire, for: indexPath) as? PostsTableCell else {
            return UITableViewCell()
        }
        
        let post = fetchedResultsController.object(at: indexPath)
        cell.updateCD(post: post)
        cell.selectionStyle = .none
        return cell
    }
}

extension SavedPostsViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        favouriteTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        favouriteTableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                favouriteTableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                favouriteTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath, let cell = favouriteTableView.cellForRow(at: indexPath) as? PostsTableCell {
                let post = fetchedResultsController.object(at: indexPath)
                cell.updateCD(post: post)
            }
        case .move:
            if let indexPath = indexPath {
                favouriteTableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let newIndexPath = newIndexPath {
                favouriteTableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        @unknown default:
            fatalError("Unknown NSFetchedResultsChangeType")
        }
    }
}

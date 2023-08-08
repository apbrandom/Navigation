//
//  ProfileViewController+Drag&Drop.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 06.08.2023.
//

import Foundation
import UIKit

extension ProfileViewController: UITableViewDropDelegate, UITableViewDragDelegate {

    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self) && session.canLoadObjects(ofClass: NSString.self)
    }

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let post = viewModel.postData[indexPath.row]
        let imageProvider = NSItemProvider(object: post.image!)
        let descriptionProvider = NSItemProvider(object: post.title as NSString)

        let imageDragItem = UIDragItem(itemProvider: imageProvider)
        let descriptionDragItem = UIDragItem(itemProvider: descriptionProvider)

        return [imageDragItem, descriptionDragItem]
    }

    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
    }

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {

        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }

        coordinator.session.loadObjects(ofClass: UIImage.self) { images in
            coordinator.session.loadObjects(ofClass: NSString.self) { descriptions in
                guard let image = images.first as? UIImage, let description = descriptions.first as? String else { return }

                // Create a new post
                let newPost = Post(title: description, author: "Drag&Drop", image: image, likes: 0, views: 0)

                PostStorage.shared.insertPost(newPost, at: destinationIndexPath.row)

                // Inserting a new row into a table
                tableView.insertRows(at: [destinationIndexPath], with: .automatic)
            }
        }
    }
}

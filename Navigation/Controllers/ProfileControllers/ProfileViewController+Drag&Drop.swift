//
//  ProfileViewController+Drag&Drop.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 06.08.2023.
//

import Foundation
import UIKit
//
//extension ProfileViewController: UITableViewDropDelegate, UITableViewDragDelegate {
//
//    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
//        return session.canLoadObjects(ofClass: UIImage.self) && session.canLoadObjects(ofClass: NSString.self)
//    }
//
//    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
//        let post = viewModel.postData[indexPath.row]
//        let imageProvider = NSItemProvider(object: post.image!)
//        let descriptionProvider = NSItemProvider(object: post.title as NSString)
//
//        let imageDragItem = UIDragItem(itemProvider: imageProvider)
//        let descriptionDragItem = UIDragItem(itemProvider: descriptionProvider)
//
//        return [imageDragItem, descriptionDragItem]
//    }
//
//    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
//        return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
//    }
//
//    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
//
//        let destinationIndexPath: IndexPath
//        if let indexPath = coordinator.destinationIndexPath {
//            destinationIndexPath = indexPath
//        } else {
//            let section = tableView.numberOfSections - 1
//            let row = tableView.numberOfRows(inSection: section)
//            destinationIndexPath = IndexPath(row: row, section: section)
//        }
//
//        coordinator.session.loadObjects(ofClass: UIImage.self) { images in
//            coordinator.session.loadObjects(ofClass: NSString.self) { descriptions in
//                guard let image = images.first as? UIImage, let description = descriptions.first as? String else { return }
//
//                // Create a new post
//                let newPost = Post(title: description, author: "Drag&Drop", image: image, likes: 0, views: 0)
//
//                PostStorage.shared.insertPost(newPost, at: destinationIndexPath.row)
//
//                // Inserting a new row into a table
//                tableView.insertRows(at: [destinationIndexPath], with: .automatic)
//            }
//        }
//    }
//}

@available(iOS 11.0, *)
extension ProfileViewController: UITableViewDragDelegate, UITableViewDropDelegate {

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard indexPath.row != 0 else { return [] }
        postDragAtIndex = indexPath.row
        let post = viewModel.postData[postDragAtIndex]
        
        guard let image = post.image else {
           print("No image captured")
        return []
        }
        
        let imageProvider = NSItemProvider(object: image)
        let imageDragItem = UIDragItem(itemProvider: imageProvider)
        imageDragItem.localObject = post.image
        
        let descriptionProvider = NSItemProvider(object: post.description as NSString)
        let descriptionDragItem = UIDragItem(itemProvider: descriptionProvider)
        descriptionDragItem.localObject = post.description
        
        return [imageDragItem, descriptionDragItem]
    }

    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self) && session.canLoadObjects(ofClass: NSString.self)
    }

    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        guard session.items.count == 2 else {
            return UITableViewDropProposal(operation: .cancel)
        }

        if tableView.hasActiveDrag {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        } else {
            return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        }
    }

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath

        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            // get from last row
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
                
        let rowInd = destinationIndexPath.row
        
        let group = DispatchGroup()
        
        var postDescription = String()
        group.enter()
        coordinator.session.loadObjects(ofClass: NSString.self) { objects in
            let uStrings = objects as! [String]
            for uString in uStrings {
                postDescription = uString
                break
            }
            group.leave()
        }
        
        var postImage = UIImage()
        group.enter()
        coordinator.session.loadObjects(ofClass: UIImage.self) { objects in
            let uImages = objects as! [UIImage]
            for uImage in uImages {
                postImage = uImage
                break
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            // delete moved post if moved
            if coordinator.proposal.operation == .move {
                PostStorage.shared.remove(at: self.postDragAtIndex)
            }
            // insert new post
            let newPost = Post(description: postDescription, author: "New author", image: postImage, likes: 0, views: 0)
            PostStorage.shared.insertPost(newPost, at: rowInd)
            
            tableView.reloadData()
        }
    }
}

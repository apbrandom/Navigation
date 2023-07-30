//
//  ProfileViewController+TableView.swift
//  Navigation
//
//  Created by Вадим Виноградов on 12.05.2023.
//

import UIKit

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        profileTableView.rowHeight = UITableView.automaticDimension
        profileTableView.estimatedRowHeight = 500
        
        profileTableView.dataSource = self
        profileTableView.delegate = self
        
        self.registerCells()
    }
    
    func registerCells() {
        profileTableView.register(
            PostsTableCell.self,
            forCellReuseIdentifier: PostsTableCell.indentifire
        )
        profileTableView.register(
            PhotosTableCell.self,
            forCellReuseIdentifier: PhotosTableCell.indentifire
        )
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbersOfRow(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        
        if indexPath.section == 0 {
            guard let photoCell = tableView.dequeueReusableCell(withIdentifier: PhotosTableCell.indentifire, for: indexPath) as? PhotosTableCell else {
                fatalError("could not dequeueReusableCell")
            }
            photoCell.update(viewModel.photoData)
            cell = photoCell
            
        } else {
            guard let postCell = tableView.dequeueReusableCell(withIdentifier: PostsTableCell.indentifire, for: indexPath) as? PostsTableCell else {
                fatalError("could not dequeueReusableCell")
            }
            postCell.update(viewModel.postData[indexPath.row])
            cell = postCell
            let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
            doubleTap.numberOfTapsRequired = 2
            cell.addGestureRecognizer(doubleTap)
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            navigationController?.pushViewController(PhotosViewController(), animated: true)
        }
    }
    
    @objc func handleDoubleTap(_ recognizer: UITapGestureRecognizer) {
        doubleTapAnimation(recognizer)
        print("Двойное нажатие")
        if let indexPath = profileTableView.indexPathForSelectedRow {
            let post = viewModel.postData[indexPath.row]
            CoreDataStorageService.shared.savePostItem(
                    title: post.title,
                    author: post.author,
                    image: post.image,
                    likes: Int32(post.likes),
                    views: Int32(post.views)
                )
            let alert = UIAlertController(title: "Post Saved", message: "Your post has been saved successfully!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func doubleTapAnimation(_ recognizer: UITapGestureRecognizer) {
        guard let cell = recognizer.view as? UITableViewCell else {
            return
        }
        
        UIView.animate(withDuration: 0.1, animations: {
            cell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
}

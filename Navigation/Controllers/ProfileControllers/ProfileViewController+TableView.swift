//
//  ProfileViewController+TableView.swift
//  Navigation
//
//  Created by Вадим Виноградов on 12.05.2023.
//

import Foundation
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
        profileTableView.register(PostsTableCell.self, forCellReuseIdentifier: PostsTableCell.indentifire)
        profileTableView.register(PhotosTableCell.self, forCellReuseIdentifier: PhotosTableCell.indentifire )
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ViewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewModel.numbersOfRow(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if ViewModel.postData.count > 0 {
            if indexPath.section == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableCell.indentifire, for: indexPath) as? PhotosTableCell else {
                    fatalError("could not dequeueReusableCell")
                }
                cell.update(ViewModel.photoData)
                cell.selectionStyle = .none
                cell.tintColor = .black
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PostsTableCell.indentifire, for: indexPath) as? PostsTableCell else {
                    fatalError("could not dequeueReusableCell")
                }
                cell.update(ViewModel.postData[indexPath.row])
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

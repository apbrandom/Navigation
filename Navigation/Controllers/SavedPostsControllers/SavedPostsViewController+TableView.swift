//
//  FavouriteViewController+TableView.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 28.07.2023.
//

import UIKit

extension SavedPostsViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbersOfRow(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostsTableCell.indentifire, for: indexPath) as? PostsTableCell else {
            return UITableViewCell()
        }
        
        let post = viewModel.post(for: indexPath.row)
        cell.updateCD(post: post)
        cell.selectionStyle = .none
        return cell
    }
}

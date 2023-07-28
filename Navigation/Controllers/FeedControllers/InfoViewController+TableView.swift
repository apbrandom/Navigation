//
//  InfoViewController+TableView.swift
//  Navigation
//
//  Created by Вадим Виноградов on 13.06.2023.
//

import UIKit

extension InfoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        residents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResidentCell", for: indexPath)
        
        cell.textLabel?.text = residents[indexPath.row].name
        return cell
    }
    
    func setupTableView() {
        residentsTableView.dataSource = self
        residentsTableView.delegate = self
        
        residentsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ResidentCell")
        
        setupLayout()
    }
    
    //MARK: - Layout
    
   private func setupLayout() {
        residentsTableView.snp.makeConstraints { make in
            make.top.equalTo(alertButton.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

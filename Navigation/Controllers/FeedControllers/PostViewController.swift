//
//  PostViewController.swift
//  Navigation
//
//  Created by Вадим Виноградов on 04.01.2023.
//

import UIKit

class PostViewController: UIViewController {
    
    weak var coordinator: FeedCoordinatable?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tuneView()
        addSubview()
    }
    
    //MARK: - Private
    
    private func tuneView() {
        view.backgroundColor = .cyan
    }
    
    private func addSubview() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .done, target: self, action: #selector(infoBarButtonItemPressed))
    }
    
    //MARK: - Action
    
    @objc func infoBarButtonItemPressed() {
        coordinator?.navigateToInfoVC()
    }
}

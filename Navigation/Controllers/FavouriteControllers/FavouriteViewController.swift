//
//  FavouriteViewController.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 25.07.2023.
//

import UIKit

class FavouriteViewController: UIViewController {
    
    weak var coordinator: FavouriteCoordinatable?
    
    deinit {
            coordinator?.finish()
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
    }
}

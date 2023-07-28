//
//  FavouriteCoordinatable.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 24.07.2023.
//

import UIKit

class SavedPostsCoordinator: SavedPostsCoordinatable {

    weak var parentCoordinator: Coordinatable?
    var childCoordinators = [Coordinatable]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
            self.navigationController = navigationController
        }
    
    func start() {
        let favouriteViewController = savedPostViewController()
        let image = UIImage(systemName: "star")
        let selectedImage = UIImage(systemName: "star.fill")
        favouriteViewController.tabBarItem = .init(title: "Favourite", image: image, selectedImage: selectedImage)
        favouriteViewController.coordinator = self
        
        navigationController.viewControllers = [favouriteViewController]
    }
    
    func finish() {
        parentCoordinator?.removeChildCoordinator(self)
    }
}

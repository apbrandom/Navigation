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
        let favouriteViewController = SavedPostsViewController()
        let image = UIImage(systemName: "square.and.arrow.down")
        let selectedImage = UIImage(systemName: "square.and.arrow.down.fill")
        favouriteViewController.tabBarItem = .init(title: "Saved", image: image, selectedImage: selectedImage)
        favouriteViewController.coordinator = self
        
        navigationController.viewControllers = [favouriteViewController]
    }
    
    func finish() {
        parentCoordinator?.removeChildCoordinator(self)
    }
}

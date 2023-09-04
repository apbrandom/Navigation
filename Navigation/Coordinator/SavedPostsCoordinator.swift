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
        let savedPostsViewController = SavedPostsViewController()
        savedPostsViewController.coordinator = self
        navigationController.viewControllers = [savedPostsViewController]
        
        setupTabBarItem()
    }
    
    private func setupTabBarItem() {
        let image = UIImage(systemName: "square.and.arrow.down")
        let selectedImage = UIImage(systemName: "square.and.arrow.down.fill")
        let text = NSLocalizedString("SavedCoordinatorTabBarItem", comment: "")
        let tabBarItem = UITabBarItem(title: text, image: image, selectedImage: selectedImage)
        navigationController.tabBarItem = tabBarItem
    }
    
    func finish() {
        parentCoordinator?.removeChildCoordinator(self)
    }
}

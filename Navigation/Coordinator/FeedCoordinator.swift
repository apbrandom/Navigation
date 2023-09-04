//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Вадим Виноградов on 18.05.2023.
//

import UIKit

class FeedCoordinator: FeedCoordinatable  {
    
    weak var parentCoordinator: Coordinatable?
    
    var childCoordinators = [Coordinatable]()
    var navigationController: UINavigationController
    let networkService: NetworkService
    
    init(navigationController: UINavigationController, networkService: NetworkService) {
            self.navigationController = navigationController
            self.networkService = networkService
        }
    
    func start() {
        let feedViewController = FeedViewController()
        navigationController.viewControllers = [feedViewController]
        
        setupTabBarItem()
    }
    
    func navigateToInfoVC() {
        let infoVC = InfoViewController(networkService: NetworkService())
            infoVC.coordinator = self
            navigationController.pushViewController(infoVC, animated: true)
    }
    
    func navigateToPostVC() {
        let postVC = PostViewController()
        postVC.coordinator = self
        navigationController.pushViewController(postVC, animated: true)
    }
    
    private func setupTabBarItem() {
        let image = UIImage(systemName: "house")
        let selectedImage = UIImage(systemName: "house.fill")
        let text = NSLocalizedString("FeedCoordinatorTabBarItem", comment: "")
        let tabBarItem = UITabBarItem(title: text, image: image, selectedImage: selectedImage)
        navigationController.tabBarItem = tabBarItem
    }
    
    func finish() {
        parentCoordinator?.removeChildCoordinator(self)
    }
}

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
        let feedVC = FeedViewController()
        let image = UIImage(systemName: "house")
        let selectedImage = UIImage(systemName: "house.fill")
        feedVC.tabBarItem = .init(title: "Feed", image: image, selectedImage: selectedImage)
        feedVC.coordinator = self
        
        navigationController.viewControllers = [feedVC]
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
    
    func finish() {
        parentCoordinator?.removeChildCoordinator(self)
    }
}

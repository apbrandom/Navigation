//
//  ApplicationCoordinator.swift
//  Navigation
//
//  Created by Вадим Виноградов on 11.05.2023.
//

import UIKit

class AppCoordinator: Coordinatable {
    
    var childCoordinators = [Coordinatable]()
    var tabBarController: UITabBarController
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        let feedNavigationController = UINavigationController()
        let feedCoordinator = FeedCoordinator(navigationController: feedNavigationController, networkService: NetworkService())
        feedCoordinator.parentCoordinator = self
        feedCoordinator.start()
        childCoordinators.append(feedCoordinator)
        
        let userService: UserService = CurrentUserService()
        let loginFactory = LoginFactory()
        let profileNavigationController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController, userService: userService, loginFactory: loginFactory)
        
        let favouriteNavigationController = UINavigationController()
        let favouriteCoordinator = FavouriteCoordinator(navigationController: favouriteNavigationController)
        favouriteCoordinator.parentCoordinator = self
        favouriteCoordinator.start()
        childCoordinators.append(favouriteCoordinator)
        
        profileCoordinator.start()
        childCoordinators.append(profileCoordinator)
        
        tabBarController.viewControllers = [
            feedCoordinator.navigationController,
            profileCoordinator.navigationController,
            favouriteCoordinator.navigationController
        ]
    }
    
    
    func finish() {}
}

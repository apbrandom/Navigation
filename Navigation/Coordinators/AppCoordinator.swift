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
        let feedNC = UINavigationController()
        let feedCoordinator = FeedCoordinator(navigationController: feedNC)
        feedCoordinator.parentCoordinator = self
        feedCoordinator.start()
        childCoordinators.append(feedCoordinator)
        
        let userService: UserService = CurrentUserService()
        let loginFactory = LoginFactory()

        let profileNC = UINavigationController()
        let profileCoordinator = ProfileCoordinator(navigationController: profileNC, userService: userService, loginFactory: loginFactory)
        
        profileCoordinator.start()
        childCoordinators.append(profileCoordinator)
        
        tabBarController.viewControllers = [
            feedCoordinator.navigationController,
            profileCoordinator.navigationController
        ]
    }
    
    func finish() {}
}

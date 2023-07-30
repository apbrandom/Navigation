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
        
        //Feed Flow
        let feedNavigationController = UINavigationController()
        let feedCoordinator = FeedCoordinator(navigationController: feedNavigationController, networkService: NetworkService())
        feedCoordinator.parentCoordinator = self
        feedCoordinator.start()
        childCoordinators.append(feedCoordinator)
        
        //Profile Flow
        let profileNavigationController = UINavigationController()
        let userService: UserService = CurrentUserService()
        let loginFactory = LoginFactory()
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController, userService: userService, loginFactory: loginFactory)
        profileCoordinator.start()
        childCoordinators.append(profileCoordinator)
        
        //SavedPosts Flow
        let savedPostsNavigationController = UINavigationController()
        let savedPostsCoordinator = SavedPostsCoordinator(navigationController: savedPostsNavigationController)
        savedPostsCoordinator.parentCoordinator = self
        savedPostsCoordinator.start()
        childCoordinators.append(savedPostsCoordinator)

        
        //Map Flow
        let mapNavigationController = UINavigationController()
        let mapCoordinator = MapCoordinator(navigationController: mapNavigationController)
        mapCoordinator.parentCoordinator = self
        mapCoordinator.start()
        childCoordinators.append(mapCoordinator)
        
        // add coordinator to tabBar
        tabBarController.viewControllers = [
            feedCoordinator.navigationController,
            profileCoordinator.navigationController,
            savedPostsCoordinator.navigationController,
            mapCoordinator.navigationController
        ]
    }
    
    func finish() {}
}

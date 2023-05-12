//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Вадим Виноградов on 11.05.2023.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var rootViewController = UITabBarController()
    var feedCoordinator: FeedCoordinator?
    var profileCoordinator: ProfileCoordinator?
    var loginInspector: LoginInspector?
    
    func start() {
        feedCoordinator = FeedCoordinator()
        feedCoordinator?.start()
        
        profileCoordinator = ProfileCoordinator()
        profileCoordinator?.start()
        
        rootViewController.viewControllers = [
            feedCoordinator?.navigationController,
            profileCoordinator?.navigationController
        ].compactMap { $0 }
    }
}

class FeedCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() {
        let feedViewController = FeedViewController()
        navigationController.pushViewController(feedViewController, animated: false)
    }
}

class ProfileCoordinator: Coordinator {
    var navigationController: UINavigationController
    var userService: UserService
    var loginFactory: LoginFactory
    
    init(navigationController: UINavigationController = UINavigationController(),
         userService: UserService = CurrentUserService(),
         loginFactory: LoginFactory = LoginFactory()) {
        self.navigationController = navigationController
        self.userService = userService
        self.loginFactory = loginFactory
    }
    
    func start() {
        let loginViewController = LoginViewController(
            userService: userService,
            loginInspector: loginFactory.makeLoginInspector()
        )
        
        loginViewController.tabBarItem = UITabBarItem(
                    title: "Feed",
                    image: UIImage(systemName: "person"),
                    tag: 0
                )
        
        navigationController.pushViewController(loginViewController, animated: false)
    }
}



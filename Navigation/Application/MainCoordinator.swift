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
        profileCoordinator?.loginInspector = loginInspector
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
    var loginInspector: LoginInspector?
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginViewController = LoginViewController()
        loginViewController.loginDelegate = loginInspector
        navigationController.pushViewController(loginViewController, animated: false)
    }
}

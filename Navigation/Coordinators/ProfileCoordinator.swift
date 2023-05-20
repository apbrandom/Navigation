//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Вадим Виноградов on 18.05.2023.
//

import UIKit

class ProfileCoordinator: ProfileCoordinatable {
    
    weak var parentCoordinator: Coordinatable?
    
    var childCoordinators = [Coordinatable]()
    var navigationController: UINavigationController
    var userService: UserService
    var loginFactory: LoginFactory

    init(navigationController: UINavigationController, userService: UserService, loginFactory: LoginFactory) {
        self.navigationController = navigationController
        self.userService = userService
        self.loginFactory = loginFactory
    }
    
    func start() {
        if userService.isAuthorized {
            let user = userService.user
            let profileVC = ProfileViewController()
            profileVC.updateUser(user)
            navigationController.viewControllers = [profileVC]
        } else {
            let loginVC = LoginViewController(userService: userService, loginInspector: loginFactory.makeLoginInspector())
            
            let image = UIImage(systemName: "person")
            let selectedImage = UIImage(systemName: "person.fill")
            loginVC.tabBarItem = .init(title: "Profile", image: image, selectedImage: selectedImage)
            loginVC.coordinator = self
            navigationController.viewControllers = [loginVC]
            parentCoordinator?.addChildCoordinator(self)
        }
    }

    func loginWith(_ login: String, _ password: String) {
        if loginFactory.makeLoginInspector().check(login: login, password: password) {
            userService.isAuthorized = true
            
            let user = userService.user
            let profileVC = ProfileViewController()
            profileVC.updateUser(user)
            navigationController.pushViewController(profileVC, animated: true)
            parentCoordinator?.removeChildCoordinator(self)
        } else {
            
            let alert = UIAlertController(title: "Unknown login", message: "Please, enter correct login and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            navigationController.present(alert, animated: true)
        }
    }
    
    func finish() {
        
    }
}

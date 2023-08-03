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
    var loginViewModel: LoginViewModel!
    
    init(navigationController: UINavigationController, userService: UserService, loginFactory: LoginFactory) {
        self.navigationController = navigationController
        self.userService = userService
        self.loginFactory = loginFactory
    }
    
    func start() {
        if userService.isAuthorized {
            let user = userService.user
            let profileViewController = ProfileViewController()
            profileViewController.updateUser(user)
            navigationController.viewControllers = [profileViewController]
        } else {
            let loginViewController = LoginViewController(userService: userService, loginInspector: loginFactory.makeLoginInspector())
            loginViewController.coordinator = self
            navigationController.viewControllers = [loginViewController]
            parentCoordinator?.addChildCoordinator(self)
        }
        
        setupTabBarItem()
    }
    
    func loginWith(_ login: String, _ password: String) {
        loginFactory.makeLoginInspector().checkCredentials(email: login, password: password) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                self.userService.isAuthorized = true
                let user = self.userService.user
                let profileVC = ProfileViewController()
                profileVC.updateUser(user)
                self.navigationController.pushViewController(profileVC, animated: true)
                self.parentCoordinator?.removeChildCoordinator(self)
                
            case .failure(_):
                let alert = UIAlertController(title: "Unknown login", message: "Please, enter correct login and password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                self.navigationController.present(alert, animated: true)
            }
        }
        
    }
    
    private func setupTabBarItem() {
        let image = UIImage(systemName: "person")
        let selectedImage = UIImage(systemName: "person.fill")
        let text = NSLocalizedString("ProfileCoordinatorTabBarItem", comment: "")
        let tabBarItem = UITabBarItem(title: text, image: image, selectedImage: selectedImage)
        navigationController.tabBarItem = tabBarItem
    }
    
    func finish() {
        parentCoordinator?.removeChildCoordinator(self)
    }
}

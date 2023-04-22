//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Вадим Виноградов on 26.12.2022.
//

import UIKit
import StorageService

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        if let url = NetworkService.randomURL() {
            NetworkService.request(url: url)
        } else {
            print("Failed to generate random URL")
        }
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        
        let window = UIWindow(windowScene: scene)
        
#if DEBUG
        let user = User.createTestUser()
        let userService: UserService = TestUserService(user: user)
#else
        let user = User.createCurrentuser()
        let userService: UserService = CurrentUserService(user: user)
#endif
    
        let controllers = [
            FeedViewController(),
            LogInViewController(currentUserService: userService)
        ]
        
        let tabBarVC = UITabBarController()
        tabBarVC.viewControllers = controllers.map {
            let _ = $0.view
            return UINavigationController(rootViewController: $0)
        }
        
        window.rootViewController = tabBarVC
        window.makeKeyAndVisible()
        
        self.window = window
        
    }
}

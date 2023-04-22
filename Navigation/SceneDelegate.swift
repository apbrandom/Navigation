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
    
    var appConfiguration: AppConfiguration?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // random url appConfiguration
        let randomValue = Int.random(in: 0..<3)
        
        switch randomValue {
        case 0:
            appConfiguration = .people(URL(string: "https://swapi.dev/api/people/8")!)
        case 1:
            appConfiguration = .starships(URL(string: "https://swapi.dev/api/starships/3")!)
        case 2:
            appConfiguration = .planets(URL(string: "https://swapi.dev/api/planets/5")!)
        default:
            break
        }
        
        if let appConfig = appConfiguration {
            NetworkService.request(configuration: appConfig)
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

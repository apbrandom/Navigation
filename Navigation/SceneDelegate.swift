//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Вадим Виноградов on 26.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        
        let controllers = [
            FeedViewController(),
            LogInViewController(),
        ]
        
        let tabBarVC = UITabBarController()
        tabBarVC.viewControllers = controllers.map {
            let _ = $0.view
            return UINavigationController(rootViewController: $0)
        }
        
        tabBarVC.tabBar.backgroundColor = UIColor.secondarySystemBackground
        
        guard let items = tabBarVC.tabBar.items else {
            return
        }
        let imeges = ["house", "person" ]
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: imeges[i])
        }
        
        window.rootViewController = tabBarVC
        window.makeKeyAndVisible()
        
        self.window = window
    }
    
}

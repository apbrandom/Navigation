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
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        
        let tabBarVC = UITabBarController()
        let feedVC = UINavigationController(rootViewController: FeedViewController())
        let profileVC = UINavigationController(rootViewController: LogInViewController())
        
        tabBarVC.tabBar.backgroundColor = UIColor.secondarySystemBackground
        feedVC.title = "Feed"
        profileVC.title = "Profile"
        
        tabBarVC.setViewControllers([feedVC, profileVC], animated: true)
        
        guard let items = tabBarVC.tabBar.items else {
            return
        }
        
        let imeges = ["house", "person" ]
        
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: imeges[i])
        }
        
        self.window?.rootViewController = tabBarVC
        self.window?.makeKeyAndVisible()
    }
    
}

//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Вадим Виноградов on 26.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    var appCoordinator: AppCoordinator?
    
    private let loginFactory = LoginFactory()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let tabBarController = UITabBarController()
        
        appCoordinator = AppCoordinator(tabBarController: tabBarController)
        appCoordinator?.start()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        //Create random URL
        if let url = NetworkService.randomURL() {
            NetworkService.request(url: url)
        } else {
            print("Failed to generate random URL")
        }
    }
}

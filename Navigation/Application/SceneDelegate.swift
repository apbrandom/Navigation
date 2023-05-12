//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Вадим Виноградов on 26.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    var applicationCoordinator: ApplicationCoordinator?
    
    private let loginFactory = LoginFactory()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        let applicationCoordinator = ApplicationCoordinator(window: window)
        applicationCoordinator.start()
            
        self.window = window
        self.applicationCoordinator = applicationCoordinator
        
        //Create random URL
        if let url = NetworkService.randomURL() {
            NetworkService.request(url: url)
        } else {
            print("Failed to generate random URL")
        }
    }
}

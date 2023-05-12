//
//  ApplicationCoordinator.swift
//  Navigation
//
//  Created by Вадим Виноградов on 11.05.2023.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    let window: UIWindow
    let mainCoordinator: MainCoordinator
    let loginInspector: LoginInspector

    init(window: UIWindow) {
            self.window = window
            self.mainCoordinator = MainCoordinator()
            self.loginInspector = LoginFactory().makeLoginInspector()
        }

    func start() {
           mainCoordinator.loginInspector = loginInspector
           mainCoordinator.start()
           
           window.rootViewController = mainCoordinator.rootViewController
           window.makeKeyAndVisible()
       }
}



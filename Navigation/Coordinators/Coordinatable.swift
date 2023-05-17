//
//  Coordinator.swift
//  Navigation
//
//  Created by Вадим Виноградов on 11.05.2023.
//

import UIKit

protocol Coordinatable: AnyObject {
    var childCoordinators: [Coordinatable] { get set }
    
    func start()
}

protocol FeedCoordinatable: Coordinatable {
    func navigateToPostVC()
    func navigateToInfoVC()
}

protocol ProfileCoordinatable: Coordinatable {
    func navigateToProfileVC()
}

class MainCoordinator: Coordinatable {
    var childCoordinators = [Coordinatable]()

    func start() {
        fatalError("Start method should be implemented.")
    }
    
    func finish() {
        fatalError("Finish method should be implemented.")
    }

    func addChildCoordinator(_ coordinator: Coordinatable) {
        for element in childCoordinators {
            if element === coordinator { return }
        }
        childCoordinators.append(coordinator)
    }

    func removeChildCoordinator(_ coordinator: Coordinatable) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}

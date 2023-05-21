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
    func finish()
}

protocol FeedCoordinatable: Coordinatable {
    func navigateToPostVC()
    func navigateToInfoVC()
}

protocol ProfileCoordinatable: Coordinatable {
    func loginWith(_ login: String, _ password: String)
}

extension Coordinatable {
    func addChildCoordinator(_ coordinator: Coordinatable) {
        childCoordinators.append(coordinator)
    }

    func removeChildCoordinator(_ coordinator: Coordinatable) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}

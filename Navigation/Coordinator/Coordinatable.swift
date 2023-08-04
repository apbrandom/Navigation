//
//  Coordinator.swift
//  Navigation
//
//  Created by Вадим Виноградов on 11.05.2023.
//

import UIKit


/// Указываем, что у любого координатора должны быть childCoordinators и методы start и finish.
protocol Coordinatable: AnyObject {
    
    /// Коллекция childCoordinators, которые управляют подкоординаторами.
    var childCoordinators: [Coordinatable] { get set }
    
    ///Метод start запускает координатор.
    func start()
    
    /// Метод finish завершает координатор.
    func finish()
}

/// Указываем, что FeedCoordinator должен иметь методы для навигации.
protocol FeedCoordinatable: Coordinatable {
    func navigateToPostVC()
    func navigateToInfoVC()
}

/// Указываем, что ProfileCoordinator должен иметь метод для логина.
protocol ProfileCoordinatable: Coordinatable {
    func loginWith(_ login: String, _ uid: String)
}


/// Базовый протокол для FavouriteCoordinator. В данном случае он не имеет специальных методов,
/// но мы оставляем его для будущего расширения.
protocol SavedPostsCoordinatable: Coordinatable {
    
}

protocol MapCoordinatable: Coordinatable {
    
}

/// Расширяем базовый протокол Coordinatable методами для добавления и удаления childCoordinators.
extension Coordinatable {
    
    /// Метод для добавления подкоординатора в коллекцию.
    func addChildCoordinator(_ coordinator: Coordinatable) {
        childCoordinators.append(coordinator)
    }
    
    /// Метод для удаления подкоординатора из коллекции.
    func removeChildCoordinator(_ coordinator: Coordinatable) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}

//
//  MapCoordinator.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 29.07.2023.
//

import UIKit

class MapCoordinator: MapCoordinatable {
    
    weak var parentCoordinator: Coordinatable?
    var childCoordinators: [Coordinatable] = []
    
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
            self.navigationController = navigationController
        }
    
    func start() {
        let mapViewController = MapViewController()
        mapViewController.coordinator = self
        navigationController.viewControllers = [mapViewController]
        
        setupTabBarItem()
    }
    
    private func setupTabBarItem() {
        let image = UIImage(systemName: "map")
        let selectedImage = UIImage(systemName: "map.fill")
        let text = NSLocalizedString("MapCoordinatorTabBarItem", comment: "")
        let tabBarItem = UITabBarItem(title: text, image: image, selectedImage: selectedImage)
        navigationController.tabBarItem = tabBarItem
    }
    
    func finish() {
        parentCoordinator?.removeChildCoordinator(self)
    }
}

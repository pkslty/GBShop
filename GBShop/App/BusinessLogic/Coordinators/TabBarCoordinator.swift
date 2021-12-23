//
//  TabBarCoordinator.swift
//  GBShop
//
//  Created by Denis Kuzmin on 23.12.2021.
//

import UIKit

class TabBarCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainTabBarController = MainTabBarController.instantiate()
        navigationController.pushViewController(mainTabBarController, animated: false)
    }
}

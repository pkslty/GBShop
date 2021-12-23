//
//  AppCoordinator.swift
//  GBShop
//
//  Created by Denis Kuzmin on 23.12.2021.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainTabBarController = MainTabBarController.instantiate()
        let nc = UINavigationController()
        let cartCoordinator = CartCoordinator(navigationController: nc)
        let authCoordinator = AuthCoordinator(navigationController: nc)
        mainTabBarController.cartCoordinator = cartCoordinator
        mainTabBarController.authCoordinator = authCoordinator
        authCoordinator.start()
        cartCoordinator.start()
        navigationController.pushViewController(mainTabBarController, animated: false)
    }
    
    
}

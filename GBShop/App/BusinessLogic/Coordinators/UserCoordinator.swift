//
//  UserCoordinator.swift
//  GBShop
//
//  Created by Denis Kuzmin on 23.12.2021.
//

import UIKit

class UserCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    @UserDefault(key: "authorizationToken", defaultValue: nil) var token: String?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        if token != nil {
            let childCoordinator = UserDetailCoordinator(navigationController: navigationController)
            childCoordinators.append(childCoordinator)
            childCoordinator.start()
        } else {
            let viewController = AuthViewController.instantiate()
            navigationController.pushViewController(viewController, animated: false)
        }
        
    }
}

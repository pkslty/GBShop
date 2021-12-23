//
//  CartCoordinator.swift
//  GBShop
//
//  Created by Denis Kuzmin on 23.12.2021.
//

import UIKit

class CartCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let cartViewController = CartViewController.instantiate()
        cartViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        navigationController.pushViewController(cartViewController, animated: false)
    }
    
    
}

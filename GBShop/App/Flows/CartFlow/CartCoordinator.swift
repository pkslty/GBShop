//
//  CartCoordinator.swift
//  GBShop
//
//  Created by Denis Kuzmin on 23.12.2021.
//

import UIKit
import SwiftUI

class CartCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var cartPresenter: CartPresenter
    var cartViewController: CartViewController
    let type: CoordinatorType = .cartCoordinator
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        let factory = RequestFactory()
        self.cartViewController = CartViewController()
        self.cartPresenter = CartPresenter(factory: factory, view: cartViewController)
        cartPresenter.coordinator = self
        cartViewController.presenter = self.cartPresenter
        navigationController.pushViewController(cartViewController, animated: true)
    }
    
    func start() {
       
        cartPresenter.getCart()
    }
    
    func childDidFinish(_ child: Coordinator, with data: Any?) {
        
    }
    
    func presenterDidFinish(with data: Any?) {
    }
    
}

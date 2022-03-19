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
    
    func start(with data: Any? = nil) {
        if let cartAction = data as? CartAction {
            let productId = cartAction.productId
            let quantity = cartAction.quantity
            let completion = cartAction.completion
            let onError = cartAction.onError
            switch cartAction.action {
            case .addToCart:
                cartPresenter.addToLocalCart(productId: productId, quantity: quantity, completion: completion, onError: onError)
            case .removeFromCart:
                cartPresenter.removeFromLocalCart(productId: productId, quantity: quantity, completion: completion, onError: onError)
            }
        } else {
            cartPresenter.getCart(completion: nil)
        }
    }
    
    func childDidFinish(_ child: Coordinator, with data: Any?) {
        
    }
    
    func presenterDidFinish(with data: Any?) {
    }
    
}

//
//  AuthCoordinator.swift
//  GBShop
//
//  Created by Denis Kuzmin on 23.12.2021.
//

import UIKit

class AuthCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    let type: CoordinatorType = .authCoordinator
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = AuthViewController(nibName: "AuthView", bundle: nil)
        let factory = RequestFactory()
        let presenter = AuthPresenter(factory: factory, view: viewController)
        presenter.coordinator = self
        viewController.presenter = presenter
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator, with data: Any?) {
        
    }
    
    func presenterDidFinish(with data: Any?) {
        parentCoordinator?.childDidFinish(self, with: data)
    }
}

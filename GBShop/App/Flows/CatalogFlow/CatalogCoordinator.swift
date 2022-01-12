//
//  CatalogCoordinator.swift
//  GBShop
//
//  Created by Denis Kuzmin on 11.01.2022.
//

import UIKit

class CatalogCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var type: CoordinatorType = .catalogCoordinator
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = CatalogViewController(nibName: "CatalogViewController", bundle: nil)
        let factory = RequestFactory()
        let catalogPresenter = CatalogPresenter(factory: factory, view: viewController)
        catalogPresenter.coordinator = self
        viewController.presenter = catalogPresenter
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator, with data: Any?) {
        
    }
    
    func presenterDidFinish(with data: Any?) {
        
    }
    
    
}

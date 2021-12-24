//
//  UserDetailCoordinator.swift
//  GBShop
//
//  Created by Denis Kuzmin on 23.12.2021.
//

import UIKit

class UserDetailCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = UserDetailViewController(nibName: "UserDetailView", bundle: nil)
        let factory = RequestFactory()
        let presenter = UserDetailPresenter(factory: factory, view: viewController)
        viewController.presenter = presenter
        navigationController.pushViewController(viewController, animated: false)
        
        
    }
    
    
}

//
//  UserDetailCoordinator.swift
//  GBShop
//
//  Created by Denis Kuzmin on 23.12.2021.
//

import UIKit

class UserDetailCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    let type: CoordinatorType = .userDetailCoordinator
    
    var user: UserResult?
    
    init(navigationController: UINavigationController, with user: UserResult? = nil) {
        self.navigationController = navigationController
        self.user = user
    }
    
    func start() {
        let viewController = UserDetailViewController(nibName: "UserDetailView", bundle: nil)
        let factory = RequestFactory()
        let presenter = UserDetailPresenter(factory: factory, view: viewController, with: user)
        presenter.coordinator = self
        viewController.presenter = presenter
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presenterDidFinish(with data: Any?) {
        //navigationController.removeFromParent()
        parentCoordinator?.childDidFinish(self, with: nil)
    }
    
    func childDidFinish(_ child: Coordinator, with data: Any?) {
    }
}

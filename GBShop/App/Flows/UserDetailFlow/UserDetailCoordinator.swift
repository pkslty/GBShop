//
//  UserDetailCoordinator.swift
//  GBShop
//
//  Created by Denis Kuzmin on 23.12.2021.
//

import UIKit

protocol UserDetailEditing {
    func editInfo()
}

class UserDetailCoordinator: Coordinator, UserDetailEditing {
    var childCoordinators = [Coordinator]()
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    let type: CoordinatorType = .userDetailCoordinator
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = UserDetailViewController(nibName: "UserDetailView", bundle: nil)
        let factory = RequestFactory()
        let presenter = UserDetailPresenter(factory: factory, view: viewController)
        presenter.coordinator = self
        viewController.presenter = presenter
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presenterDidFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func childDidFinish(_ child: Coordinator) {
    }
    
    func editInfo() {
        let editInfoViewController = UserEditInfoViewController(role: .editInfo)
        navigationController.pushViewController(editInfoViewController, animated: true)
    }
}

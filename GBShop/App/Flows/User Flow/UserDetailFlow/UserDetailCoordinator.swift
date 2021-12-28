//
//  UserDetailCoordinator.swift
//  GBShop
//
//  Created by Denis Kuzmin on 23.12.2021.
//

import UIKit

protocol UserDetailEditable {
    func editInfo(of user: UserResult?)
    func didSaveUserInfo()
}

class UserDetailCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    let type: CoordinatorType = .userDetailCoordinator
    var factory: RequestFactory
    
    var user: UserResult?
    
    init(navigationController: UINavigationController, with user: UserResult? = nil) {
        self.navigationController = navigationController
        self.user = user
        self.factory = RequestFactory()
    }
    
    func start() {
        let viewController = UserDetailViewController(nibName: "UserDetailView", bundle: nil)
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

extension UserDetailCoordinator: UserDetailEditable {
    func editInfo(of user: UserResult?) {
        self.user = user
        let editInfoViewController = UserEditInfoViewController(role: .editInfo)
        let presenter = UserEditInfoPresenter(factory: factory, view: editInfoViewController, with: user)
        presenter.coordinator = self
        editInfoViewController.presenter = presenter
        navigationController.pushViewController(editInfoViewController, animated: true)
    }
    
    func didSaveUserInfo() {
        navigationController.popViewController(animated: true)
    }
}


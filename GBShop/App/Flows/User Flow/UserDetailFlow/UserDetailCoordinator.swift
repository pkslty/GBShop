//
//  UserDetailCoordinator.swift
//  GBShop
//
//  Created by Denis Kuzmin on 23.12.2021.
//

import UIKit

protocol UserDetailEditable {
    func editInfo(of user: UserResult?)
    func didSaveUserInfo(with user: User)
}

class UserDetailCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    let type: CoordinatorType = .userDetailCoordinator
    var factory: RequestFactory
    var userDetailPresenter: UserDetailPresenter?
    
    var user: UserResult?
    
    init(navigationController: UINavigationController, with user: UserResult? = nil) {
        self.navigationController = navigationController
        self.user = user
        self.factory = RequestFactory()
    }
    
    func start() {
        navigationController.children.forEach {
            if $0 is UserDetailViewController {
                $0.removeFromParent()
            }
        }
        let viewController = UserDetailViewController(nibName: "UserDetailView", bundle: nil)
        userDetailPresenter = UserDetailPresenter(factory: factory, view: viewController, with: user)
        userDetailPresenter?.coordinator = self
        viewController.presenter = userDetailPresenter
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
        let userEditInfoPresenter = UserEditInfoPresenter(factory: factory, view: editInfoViewController, with: user)
        userEditInfoPresenter.coordinator = self
        editInfoViewController.presenter = userEditInfoPresenter
        
        navigationController.pushViewController(editInfoViewController, animated: true)
        
    }
    
    func didSaveUserInfo(with user: User) {
        self.user = UserResult(id: user.id,
                               login: user.login,
                               name: user.name,
                               lastname: user.lastname,
                               email: user.email,
                               gender: user.gender,
                               creditCard: user.creditCard,
                               bio: user.bio)
        userDetailPresenter?.user = self.user
        navigationController.navigationBar.isHidden = true
        navigationController.popViewController(animated: true)
        
    }
}


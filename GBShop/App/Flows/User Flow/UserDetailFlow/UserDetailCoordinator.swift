//
//  UserDetailCoordinator.swift
//  GBShop
//
//  Created by Denis Kuzmin on 23.12.2021.
//

import UIKit

protocol UserDetailEditable {
    func editInfo(of user: User?)
    func didSaveUserInfo(with user: User)
}

class UserDetailCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    let type: CoordinatorType = .userDetailCoordinator
    var factory: RequestFactory
    var userDetailPresenter: UserDetailPresenter?
    
    var user: User?
    
    init(navigationController: UINavigationController, with user: User? = nil) {
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
        parentCoordinator?.childDidFinish(self, with: nil)
    }
    
    func childDidFinish(_ child: Coordinator, with data: Any?) {
    }
}

extension UserDetailCoordinator: UserDetailEditable {
    func editInfo(of user: User?) {
        self.user = user
        let editInfoViewController = UserEditInfoViewController(role: .editInfo)
        let userEditInfoPresenter = UserEditInfoPresenter(factory: factory, view: editInfoViewController, with: user)
        userEditInfoPresenter.coordinator = self
        editInfoViewController.presenter = userEditInfoPresenter
        
        navigationController.pushViewController(editInfoViewController, animated: true)
        
    }
    //MARK - Need to refactor
    func didSaveUserInfo(with user: User) {
        self.user = user
        userDetailPresenter?.user = self.user
        navigationController.popViewController(animated: true)
        
    }
}


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
    var authPresenter: AuthPresenter?
    var factory: RequestFactory
    let type: CoordinatorType = .authCoordinator
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.factory = RequestFactory()
    }
    
    func start(with data: Any? = nil) {
        navigationController.children.forEach {
            if $0 is AuthViewController {
                $0.removeFromParent()
            }
        }
        let viewController = AuthViewController(nibName: "AuthView", bundle: nil)
        let factory = RequestFactory()
        authPresenter = AuthPresenter(factory: factory, view: viewController)
        authPresenter?.coordinator = self
        viewController.presenter = authPresenter
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator, with data: Any?) {
        
    }
    
    func presenterDidFinish(with data: Any?) {
        parentCoordinator?.childDidFinish(self, with: data)
    }
}

extension AuthCoordinator: SignUppable {
    
    func signUp() {
        let signUpViewController = UserEditInfoViewController(role: .register)
        
        let signUpPresenter = SignUpPresenter(factory: factory, view: signUpViewController)
        signUpViewController.presenter = signUpPresenter
        signUpPresenter.coordinator = self
        
        navigationController.pushViewController(signUpViewController, animated: true)
    }
}

extension AuthCoordinator: UserDetailEditable {
    func editInfo(of user: User?) {
        
    }
    
    func didSaveUserInfo(with user: User) {
        
    }
}

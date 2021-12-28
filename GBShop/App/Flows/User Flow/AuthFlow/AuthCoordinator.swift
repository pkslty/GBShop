//
//  AuthCoordinator.swift
//  GBShop
//
//  Created by Denis Kuzmin on 23.12.2021.
//

import UIKit

protocol SignUppable {
    func signUp()
}

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
    
    func start() {
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
        navigationController.navigationBar.isHidden = true
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
        let signUpPresenter = SignUpPresenter(factory: factory)
        let signUpViewController = UserEditInfoViewController(role: .register)
        signUpViewController.presenter = signUpPresenter
        
        navigationController.pushViewController(signUpViewController, animated: true)
        
        
        
    }
}

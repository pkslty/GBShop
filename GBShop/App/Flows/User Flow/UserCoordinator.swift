//
//  UserCoordinator.swift
//  GBShop
//
//  Created by Denis Kuzmin on 23.12.2021.
//

import UIKit

class UserCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    let type: CoordinatorType = .userCoordinator
    
    @UserDefault(key: "authorizationToken", defaultValue: nil) var token: String?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        var childCoordinator: Coordinator
        if token != nil {
            childCoordinator = UserDetailCoordinator(navigationController: navigationController)
        } else {
            childCoordinator = AuthCoordinator(navigationController: navigationController)
        }
        childCoordinators.append(childCoordinator)
        childCoordinator.parentCoordinator = self
        childCoordinator.start()
    }
    
    func childDidFinish(_ child: Coordinator, with data: Any?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
            }
        }
        var newChild: Coordinator
        switch child.type {
        case .userDetailCoordinator:
            newChild = AuthCoordinator(navigationController: navigationController)
            childCoordinators.append(newChild)
            newChild.parentCoordinator = self
            newChild.start()
        case .authCoordinator:
            if token != nil {
                newChild = UserDetailCoordinator(navigationController: navigationController, with: data as? User)
                childCoordinators.append(newChild)
                newChild.parentCoordinator = self
                newChild.start()
            }
        default:
            return
        }
    }
    
    func presenterDidFinish(with data: Any?) {
    }
}

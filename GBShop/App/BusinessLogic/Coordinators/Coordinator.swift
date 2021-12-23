//
//  Coordinator.swift
//  GBShop
//
//  Created by Denis Kuzmin on 23.12.2021.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set}
    var navigationController: UINavigationController { get set}
    
    func start()
}

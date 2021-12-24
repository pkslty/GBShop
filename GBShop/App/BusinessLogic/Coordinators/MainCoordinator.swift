//
//  AppCoordinator.swift
//  GBShop
//
//  Created by Denis Kuzmin on 23.12.2021.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, UITabBarControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }
    
    func start() {
        let pages: [TabBarPage] = [.catalog, .cart, .user]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        
        prepareTabBarController(withTabControllers: controllers)
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.delegate = self
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.catalog.pageOrderNumber()
        tabBarController.tabBar.isTranslucent = false
        
        navigationController.viewControllers = [tabBarController]
    }
    
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(false, animated: false)

        navigationController.tabBarItem = UITabBarItem(title: page.pageTitleValue(),
                                                       image: page.pageIcon(),
                                                     tag: page.pageOrderNumber())

        switch page {
        case .catalog:
            // If needed: Each tab bar flow can have it's own Coordinator.
            let catalogViewController = AuthViewController.instantiate()
            navigationController.pushViewController(catalogViewController, animated: true)
        case .cart:
            let cartViewController = CartViewController.instantiate()
            navigationController.pushViewController(cartViewController, animated: true)
        case .user:
            let userCoordinator = UserCoordinator(navigationController: navigationController)
            userCoordinator.start()
            //let userViewController = AuthViewController.instantiate()
            //navigationController.pushViewController(userViewController, animated: true)
        }
        
        return navigationController
    }
    
    func currentPage() -> TabBarPage? { TabBarPage.init(index: tabBarController.selectedIndex) }

    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage.init(index: index) else { return }
        
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
}


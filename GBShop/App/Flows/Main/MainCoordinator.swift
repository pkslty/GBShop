//
//  AppCoordinator.swift
//  GBShop
//
//  Created by Denis Kuzmin on 23.12.2021.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, UITabBarControllerDelegate {
    var childCoordinators = [Coordinator]()
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    let type: CoordinatorType = .mainCoordinator
    
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
    
    func childDidFinish(_ child: Coordinator, with data: Any?) {
        
    }
    
    func presenterDidFinish(with data: Any?) {
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
        navigationController.tabBarItem.badgeColor = .purple

        switch page {
        case .catalog:
            let catalogCoordinator = CatalogCoordinator(navigationController: navigationController)
            catalogCoordinator.start()
        case .cart:
            let cartCoordinator = CartCoordinator(navigationController: navigationController)
            cartCoordinator.start()
        case .user:
            let userCoordinator = UserCoordinator(navigationController: navigationController)
            userCoordinator.start()
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


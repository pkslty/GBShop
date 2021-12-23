//
//  MainTabBarController.swift
//  GBShop
//
//  Created by Denis Kuzmin on 23.12.2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    var authCoordinator: AuthCoordinator!
    var cartCoordinator: CartCoordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .white
        print("we are here")
        viewControllers = [authCoordinator.navigationController, cartCoordinator.navigationController]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

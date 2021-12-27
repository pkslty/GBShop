//
//  TabBarPage.swift
//  GBShop
//
//  Created by Denis Kuzmin on 23.12.2021.
//

import UIKit

enum TabBarPage {
    case catalog
    case cart
    case user

    init?(index: Int) {
        switch index {
        case 0:
            self = .catalog
        case 1:
            self = .cart
        case 2:
            self = .user
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .catalog:
            return "Catalog"
        case .cart:
            return "Cart"
        case .user:
            return "User"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .catalog:
            return 0
        case .cart:
            return 1
        case .user:
            return 2
        }
    }
    
    func pageIcon() -> UIImage? {
        switch self {
        case .catalog:
            return UIImage(systemName: "folder")
        case .cart:
            return UIImage(systemName: "cart")
        case .user:
            return UIImage(systemName: "person")
        }
    }
}

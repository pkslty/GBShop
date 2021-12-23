//
//  Storyboarded.swift
//  GBShop
//
//  Created by Denis Kuzmin on 23.12.2021.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension UIViewController: Storyboarded {
    
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        print(fullName)
        print(className)
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        print(storyboard)
        
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
    
    
}

//
//  ShoppingRequestFactory.swift
//  GBShop
//
//  Created by Denis Kuzmin on 16.12.2021.
//

import Alamofire
import Foundation

protocol ShoppingRequestFactory {
    func addToCart(productId: Int, userId: Int, quantity: Int,
                  completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void)
    
    func removeFromCart(productId: Int, userId: Int, quantity: Int,
                  completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void)
    
    func payCart(userId: Int, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void)
}

//
//  ShoppingRequestFactory.swift
//  GBShop
//
//  Created by Denis Kuzmin on 16.12.2021.
//

import Alamofire
import Foundation

protocol ShoppingRequestFactory {
    func addToCart(productId: UUID, userId: UUID, quantity: Int,
                  completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void)
    
    func removeFromCart(productId: UUID, userId: UUID, quantity: Int,
                  completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void)
    
    func payCart(userId: UUID, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void)
    
    func getCart(userId: UUID, completionHandler: @escaping (AFDataResponse<GetCartResponse>) -> Void)
}

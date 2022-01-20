//
//  Shopping.swift
//  GBShop
//
//  Created by Denis Kuzmin on 16.12.2021.
//

import Alamofire
import Foundation

class Shopping: AbstractRequestFactory {
    
    var errorParser: AbstractErrorParser
    var sessionManager: Session
    var queue: DispatchQueue
    let baseUrl = URL(string: "https://vast-hollows-60312.herokuapp.com/")!
    //let baseUrl = URL(string: "http://127.0.0.1:8080/")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Shopping: ShoppingRequestFactory {
    func addToCart(productId: Int, userId: Int, quantity: Int, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void) {
        let requestModel = ShoppingData(baseUrl: baseUrl, path: "addToCart", productId: productId, userId: userId, quantity: quantity)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func removeFromCart(productId: Int, userId: Int, quantity: Int, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void) {
        let requestModel = ShoppingData(baseUrl: baseUrl, path: "removeFromCart", productId: productId, userId: userId, quantity: quantity)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func payCart(userId: Int, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void) {
        let requestModel = ShoppingData(baseUrl: baseUrl, path: "payCart", userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Shopping {
    
    struct ShoppingData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        var path: String
        
        var productId: Int? = nil
        var userId: Int? = nil
        var quantity: Int? = nil
        var parameters: Parameters? {
            return [
                "productId": productId as Any,
                "userId": userId as Any,
                "quantity": quantity as Any
            ]
        }
        
        init(baseUrl: URL, path: String, productId: Int, userId: Int, quantity: Int) {
            self.baseUrl = baseUrl
            self.path = path
            self.productId = productId
            self.userId = userId
            self.quantity = quantity
        }
        
        init(baseUrl: URL, path: String, userId: Int) {
            self.baseUrl = baseUrl
            self.path = path
            self.userId = userId
        }
        
    }
}

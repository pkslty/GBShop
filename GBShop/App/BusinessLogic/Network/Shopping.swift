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
    //let baseUrl = URL(string: "https://vast-hollows-60312.herokuapp.com/")!
    let baseUrl = URL(string: "http://127.0.0.1:8080/")!
    
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
    func addToCart(productId: UUID, userId: UUID, quantity: Int, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void) {
        let requestModel = AddRemoveData(baseUrl: baseUrl, path: "addToCart", productId: productId, userId: userId, quantity: quantity)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func removeFromCart(productId: UUID, userId: UUID, quantity: Int, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void) {
        let requestModel = AddRemoveData(baseUrl: baseUrl, path: "removeFromCart", productId: productId, userId: userId, quantity: quantity)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func payCart(userId: UUID, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void) {
        let requestModel = payCartData(baseUrl: baseUrl, path: "payCart", userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Shopping {
    
    struct AddRemoveData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        var path: String
        
        var productId: UUID
        var userId: UUID
        var quantity: Int
        var parameters: Parameters? {
            return [
                "productId": productId,
                "userId": userId,
                "quantity": quantity
            ]
        }
    }
    
    struct payCartData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        var path: String
        
        var userId: UUID
        var parameters: Parameters? {
            return [
                "userId": userId,
            ]
        }
    }
}

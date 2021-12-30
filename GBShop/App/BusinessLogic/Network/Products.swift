//
//  Goods.swift
//  GBShop
//
//  Created by Denis Kuzmin on 06.12.2021.
//

import Alamofire
import Foundation

class Products: AbstractRequestFactory {
    
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

extension Products: ProductsRequestFactory {
    
    func getProductById(id: Int, completionHandler: @escaping (AFDataResponse<ProductByIdResult>) -> Void) {
        let requestModel = ProductData(baseUrl: baseUrl, path: "getProductById", id: id)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func getProductsList(page: Int, categoryId: Int, completionHandler: @escaping (AFDataResponse<ProductsListResult>) -> Void) {
        let requestModel = GoodsListData(baseUrl: baseUrl, path: "getProductsList", page: page, categoryId: categoryId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    
}

extension Products {
    struct ProductData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        var path: String
        
        let id: Int
        var parameters: Parameters? {
            return [
                "productId": id
            ]
        }
    }
    
    struct GoodsListData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        var path: String
        
        let page: Int
        let categoryId: Int
        var parameters: Parameters? {
            return [
                "pageNumber": page,
                "categoryId": categoryId
            ]
        }
    }
}

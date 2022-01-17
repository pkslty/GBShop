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
    func getCategories(completionHandler: @escaping (AFDataResponse<GetListResponse>) -> Void) {
        let requestModel = GetListData(baseUrl: baseUrl, method: .get, path: "getCategories")
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func getBrands(completionHandler: @escaping (AFDataResponse<GetListResponse>) -> Void) {
        let requestModel = GetListData(baseUrl: baseUrl, method: .get, path: "getBrands")
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func getBrandById(brandId: UUID, completionHandler: @escaping (AFDataResponse<GetBrandByIdResponse>) -> Void) {
        let requestModel = GetListData(baseUrl: baseUrl, method: .post, path: "getBrandById", brandId: brandId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func getBrandCategories(brandId: UUID, completionHandler: @escaping (AFDataResponse<GetListResponse>) -> Void) {
        let requestModel = GetListData(baseUrl: baseUrl, method: .post, path: "getBrandCategories", brandId: brandId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func getProductById(id: UUID, completionHandler: @escaping (AFDataResponse<ProductByIdResponse>) -> Void) {
        let requestModel = ProductData(baseUrl: baseUrl, path: "getProductById", id: id)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func getProductsList(page: Int, categoryId: UUID, completionHandler: @escaping (AFDataResponse<ProductsListResponse>) -> Void) {
        let requestModel = GoodsListData(baseUrl: baseUrl, path: "getProductsList", page: page, categoryId: categoryId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func getProductPhotos(productId: UUID, completionHandler: @escaping (AFDataResponse<GetProductPhotosResponse>) -> Void) {
        let requestModel = GetListData(baseUrl: baseUrl, method: .post, path: "getProductPhotos", productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

extension Products {
    struct ProductData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        var path: String
        
        let id: UUID
        var parameters: Parameters? {
            return [
                "productId": id
            ]
        }
    }
    
    struct GetListData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod
        var path: String
        var brandId: UUID?
        var productId: UUID?
        
        var parameters: Parameters? {
            if let brandId = brandId {
                return [
                    "id": brandId
                ]
            } else {
                if let productId = productId {
                    return [
                        "id": productId
                    ]
                } else {
                    return nil
                }
            }
        }
        
        init(baseUrl: URL, method: HTTPMethod, path: String, brandId: UUID? = nil, productId: UUID? = nil) {
            self.baseUrl = baseUrl
            self.method = method
            self.path = path
            self.brandId = brandId
            self.productId = productId
        }
    }
    
    struct GoodsListData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        var path: String
        
        let page: Int
        let categoryId: UUID
        var parameters: Parameters? {
            return [
                "pageNumber": page,
                "categoryId": categoryId
            ]
        }
    }
}

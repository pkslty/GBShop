//
//  GoodsRequestFactory.swift
//  GBShop
//
//  Created by Denis Kuzmin on 06.12.2021.
//

import Alamofire
import Foundation

protocol ProductsRequestFactory {
    func getProductById(id: UUID,
                  completionHandler: @escaping (AFDataResponse<ProductByIdResponse>) -> Void)
    
    func getProductsList(page: Int, categoryId: UUID,
                  completionHandler: @escaping (AFDataResponse<ProductsListResponse>) -> Void)
}

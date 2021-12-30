//
//  GoodsRequestFactory.swift
//  GBShop
//
//  Created by Denis Kuzmin on 06.12.2021.
//

import Alamofire
import Foundation

protocol ProductsRequestFactory {
    func getProductById(id: Int,
                  completionHandler: @escaping (AFDataResponse<ProductByIdResult>) -> Void)
    
    func getProductsList(page: Int, categoryId: Int,
                  completionHandler: @escaping (AFDataResponse<ProductsListResult>) -> Void)
}

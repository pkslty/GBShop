//
//  GoodsRequestFactory.swift
//  GBShop
//
//  Created by Denis Kuzmin on 06.12.2021.
//

import Alamofire
import Foundation

protocol GoodsRequestFactory {
    func getGoodById(id: Int,
                  completionHandler: @escaping (AFDataResponse<GoodByIdResult>) -> Void)
    
    func getGoodsList(page: Int, categoryId: Int,
                  completionHandler: @escaping (AFDataResponse<GoodsListResult>) -> Void)
}

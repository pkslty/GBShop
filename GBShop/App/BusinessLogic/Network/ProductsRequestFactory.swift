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
    
    func getCategories(completionHandler: @escaping (AFDataResponse<GetListResponse>) -> Void)
    
    func getBrands(completionHandler: @escaping (AFDataResponse<GetListResponse>) -> Void)
    
    func getBrandCategories(brandId: UUID, completionHandler: @escaping (AFDataResponse<GetListResponse>) -> Void)
    
    func getBrandById(brandId: UUID, completionHandler: @escaping (AFDataResponse<GetBrandByIdResponse>) -> Void)
    
    func getProductPhotos(productId: UUID, completionHandler: @escaping (AFDataResponse<GePhotosResponse>) -> Void)
}

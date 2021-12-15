//
//  ReviewsRequestFactory.swift
//  GBShop
//
//  Created by Denis Kuzmin on 15.12.2021.
//

import Alamofire
import Foundation

protocol ReviewsRequestFactory {
    func getReviews(productId: Int,
                  completionHandler: @escaping (AFDataResponse<GetReviewsResult>) -> Void)
    
    func addReview(productId: Int, userId: Int, text: String, rating: Int,
                  completionHandler: @escaping (AFDataResponse<CommonResult>) -> Void)
    
    func removeReview(reviewId: Int, completionHandler: @escaping (AFDataResponse<CommonResult>) -> Void)
}

//
//  ReviewsRequestFactory.swift
//  GBShop
//
//  Created by Denis Kuzmin on 15.12.2021.
//

import Alamofire
import Foundation

protocol ReviewsRequestFactory {
    func getReviews(productId: UUID,
                  completionHandler: @escaping (AFDataResponse<GetReviewsResult>) -> Void)
    
    func addReview(productId: UUID, userId: UUID, text: String, rating: Int,
                  completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void)
    
    func removeReview(reviewId: UUID, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void)
}

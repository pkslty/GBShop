//
//  Reviews.swift
//  GBShop
//
//  Created by Denis Kuzmin on 15.12.2021.
//

import Alamofire
import Foundation

class Reviews: AbstractRequestFactory {
    
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

extension Reviews: ReviewsRequestFactory {
    func getReviews(productId: Int, completionHandler: @escaping (AFDataResponse<GetReviewsResult>) -> Void) {
        let requestModel = GetReviewsData(baseUrl: baseUrl, path: "getReviews", productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func addReview(productId: Int, userId: Int, text: String, rating: Int, completionHandler: @escaping (AFDataResponse<CommonResult>) -> Void) {
        let requestModel = AddReviewData(baseUrl: baseUrl, path: "addReview", productId: productId, userId: userId, text: text, rating: rating)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func removeReview(reviewId: Int, completionHandler: @escaping (AFDataResponse<CommonResult>) -> Void) {
        let requestModel = RemoveReviewData(baseUrl: baseUrl, path: "removeReview", reviewId: reviewId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Reviews {
    struct GetReviewsData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        var path: String
        
        let productId: Int
        var parameters: Parameters? {
            return [
                "productId": productId
            ]
        }
    }
    
    struct AddReviewData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        var path: String
        
        let productId: Int
        let userId: Int
        let text: String
        let rating: Int
        var parameters: Parameters? {
            return [
                "productId": productId,
                "userId": userId,
                "text": text,
                "rating": rating
            ]
        }
    }
    
    struct RemoveReviewData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        var path: String
        
        let reviewId: Int
        var parameters: Parameters? {
            return [
                "reviewId": reviewId
            ]
        }
    }
}

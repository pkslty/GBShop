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
    func getReviews(productId: UUID, completionHandler: @escaping (AFDataResponse<GetReviewsResult>) -> Void) {
        let requestModel = ReviewData(baseUrl: baseUrl, path: "getReviews", productId: productId)
        print(requestModel)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func addReview(productId: UUID, userId: UUID, text: String, rating: Int, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void) {
        let requestModel = ReviewData(baseUrl: baseUrl, path: "addReview", productId: productId, userId: userId, text: text, rating: rating)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func removeReview(reviewId: UUID, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void) {
        let requestModel = ReviewData(baseUrl: baseUrl, path: "removeReview", reviewId: reviewId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Reviews {
    struct GetReviewsData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        var path: String
        
        let productId: UUID
        var parameters: Parameters? {
            return [
                "productId": productId
            ]
        }
    }
    
    struct ReviewData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        var path: String
        
        var productId: UUID? = nil
        var userId: UUID? = nil
        var text: String? = nil
        var rating: Int? = nil
        var reviewId: UUID? = nil
        var parameters: Parameters? {
            if let reviewId = reviewId {
                return [
                    "reviewId": reviewId
                ]
            } else {
                if let userId = userId, let text = text, let rating = rating, let productId = productId {
                    return [
                        "productId": productId,
                        "userId": userId,
                        "text": text,
                        "rating": rating
                    ]
                } else {
                    if let productId = productId {
                        return [
                            "productId": productId
                        ]
                    } else {
                        return [:]
                    }
                }
            }
            
        }
        
        init(baseUrl: URL, path: String, productId: UUID) {
            self.baseUrl = baseUrl
            self.path = path
            self.productId = productId
        }
        
        init(baseUrl: URL, path: String, reviewId: UUID) {
            self.baseUrl = baseUrl
            self.path = path
            self.reviewId = reviewId
        }
        
        init(baseUrl: URL, path: String, productId: UUID, userId: UUID, text: String, rating: Int) {
            self.baseUrl = baseUrl
            self.path = path
            self.productId = productId
            self.userId = userId
            self.text = text
            self.rating = rating
        }
    }
}

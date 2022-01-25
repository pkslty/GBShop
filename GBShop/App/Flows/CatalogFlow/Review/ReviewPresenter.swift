//
//  ReviewPresenter.swift
//  GBShop
//
//  Created by Denis Kuzmin on 19.01.2022.
//

import Foundation
import UIKit

protocol ReviewAddable {
    func addReview(productId: UUID)
}

class ReviewPresenter {
    var view: ReviewView
    var factory: RequestFactory
    var coordinator: (Coordinator&ReviewAddable)?
    let productId: UUID

    var reviews: [Review]?
    var authors: [String]?
    var reviewPhotos = [Int:[UIImage]]()
    @UserDefault(key: "authorizationToken", defaultValue: nil) var token: String?

    init(factory: RequestFactory, view: ReviewView, productId: UUID) {
        self.factory = factory
        self.view = view
        self.productId = productId
    }
    
    func load() {
        getReviews {
            self.setData()
        }
        getProduct {
            self.view.setProductName(name: $0.productName)
        }
    }
    
    func addReviewButtonPressed() {
        if token != nil {
            coordinator?.addReview(productId: productId)
        } else {
            view.showAlert("Warning", "You have to Sign in first", nil)
        }
    }
    
    private func getReviews(completion: @escaping () -> Void) {
        let request = factory.makeReviewsRequestFactory()
        request.getReviews(productId: productId) { response in
            if let value = response.value {
                switch value.result {
                case 1:
                    if let reviews = value.reviews {
                        let group = DispatchGroup()
                        for (row, review) in reviews.enumerated() {
                            group.enter()
                            self.getReviewsPhotos(row: row, reviewId: review.id) {
                                group.leave()
                            }
                        }
                        group.wait()
                        DispatchQueue.main.async {
                            self.reviews = reviews
                            completion()
                        }
                    }
                default: break
                }
            }
        }
    }
    
    
    private func getReviewsPhotos(row: Int, reviewId: UUID, completion: @escaping () -> Void) {
        let request = factory.makeReviewsRequestFactory()
        request.getReviewPhotos(reviewId: reviewId) { response in
            if let value = response.value {
                var imagesArray = [UIImage]()
                let group = DispatchGroup()
                switch value.result {
                case 1:
                    if let photos = value.photos {
                        
                        for photo in photos {
                            group.enter()
                            DispatchQueue.main.async {
                                ImageLoader.getImage(from: photo.urlString) { image in
                                    if let image = image {
                                        imagesArray.append(image)
                                    }
                                    group.leave()
                                }
                            }
                            
                        }
                    }
                default:
                    break
                }
                group.wait()
                DispatchQueue.main.async {
                    self.reviewPhotos[row] = imagesArray
                    completion()
                    //self.setPhotos()
                }
            }
        }
    }
    
    private func getProduct(completion: @escaping (Product) -> Void) {
        let request = factory.makeProductsRequestFactory()
        request.getProductById(id: productId) { response in
            if let value = response.value {
                DispatchQueue.main.async {
                    switch value.result {
                    case 1:
                        if let product = value.product {
                            completion(product)
                        }
                    default:
                        break
                    }
                }
            }
        }
    }
    
    private func setData() {
        guard let reviews = reviews else { return }
        var data = reviews.map { ReviewViewItem(author: $0.screenName ?? "Anonymous",
                                                avatarUrlString: $0.avatarUrlString ?? "http://dnk.net.ru/gb_shop/photos/users/en_logo.png",
                                                text: $0.text,
                                                rating: $0.rating,
                                                photos: nil) }
        for num in 0 ... data.count - 1 {
            data[num].photos = reviewPhotos[num]
        }
        
        view.setData(reviews: data)
    }

}

//
//  ReviewPresenter.swift
//  GBShop
//
//  Created by Denis Kuzmin on 19.01.2022.
//

import Foundation
import UIKit

class ReviewPresenter {
    var view: ReviewView
    var factory: RequestFactory
    var coordinator: Coordinator?
    let productId: UUID

    var reviews: [Review]?
    var reviewPhotos: [Int:[UIImage]]?

    init(factory: RequestFactory, view: ReviewView, productId: UUID) {
        self.factory = factory
        self.view = view
        self.productId = productId
    }
    
    func load() {
        getReviews()
    }
    
    
    private func getReviews() {
        let request = factory.makeReviewsRequestFactory()
        request.getReviews(productId: productId) { response in
            if let value = response.value {
                DispatchQueue.main.async {
                    switch value.result {
                    case 1:
                        if let reviews = value.reviews {
                            self.reviews = reviews
                            //self.getReviewsPhotos()
                        }
                    default: break
                    }
                }
            }
        }
    }
    
 /*   private func getReviewsPhotos() {
        let request = factory.makeProductsRequestFactory()
        request.getProductPhotos(productId: productId) { response in
            if let value = response.value {
                let group = DispatchGroup()
                switch value.result {
                case 1:
                    if let photos = value.photos {
                        for photo in photos {
                            group.enter()
                            DispatchQueue.main.async {
                                ImageLoader.getImage(from: photo.urlString) {[weak self] image in
                                    guard let self = self else {
                                        group.leave()
                                        return }
                                    if let image = image {
                                        self.photos.append(image)
                                    }
                                    group.leave()
                                }
                            }
                            
                        }
                    }
                default:
                    group.enter()
                    DispatchQueue.main.async {
                        ImageLoader.getImage(from: "http://dnk.net.ru/gb_shop/photos/place_holder.png") {[weak self] image in
                            guard let self = self else {
                                group.leave()
                                return }
                            if let image = image {
                                self.photos.append(image)
                            }
                            group.leave()
                        }
                    }
                }
                group.wait()
                DispatchQueue.main.async {
                    self.setPhotos()
                }
            }
        }
    }*/
    
    
    private func setPhotos() {

    }
    
    private func setData(product: Product) {
        
    }
}

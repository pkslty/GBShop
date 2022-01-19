//
//  ProductPresenter.swift
//  GBShop
//
//  Created by Denis Kuzmin on 18.01.2022.
//

import Foundation
import UIKit

protocol ReviewShowable {
    func showReviews(productId: UUID)
}

class ProductPresenter {
    var view: ProductView
    var factory: RequestFactory
    var coordinator: (Coordinator&ReviewShowable)?
    let productId: UUID

    var photos = [UIImage]() {
        didSet {

        }
    }

    let currencySign = "₽"

    
    init(factory: RequestFactory, view: ProductView, productId: UUID) {
        self.factory = factory
        self.view = view
        self.productId = productId
    }
    
    func load() {
        getProduct()
        getPhotos()
        getReviews()
    }
    
    func addToCart() {
        
    }
    
    func showReviews() {
        coordinator?.showReviews(productId: productId)
    }
    
    private func getReviews() {
        let request = factory.makeReviewsRequestFactory()
        request.getReviews(productId: productId) { response in
            if let value = response.value {
                DispatchQueue.main.async {
                    switch value.result {
                    case 1:
                        if let reviews = value.reviews {
                            let reviewsNumber = reviews.count
                            let text = reviewsNumber == 1 ? "\(reviewsNumber) Review" : "\(reviewsNumber) Reviews"
                            self.view.setReviewsText(text: text)
                        }
                    default: break
                    }
                }
            }
        }
    }
    
    private func getPhotos() {
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
    }
    
    private func getProduct() {
        let request = factory.makeProductsRequestFactory()
        request.getProductById(id: productId) { response in
            if let value = response.value {
                DispatchQueue.main.async {
                    switch value.result {
                    case 1:
                        if let product = value.product {
                            self.setData(product: product)
                            self.view.setRating(rating: product.rating)
                        }
                    default:
                        break
                    }
                }
            }
        }
    }
    
    private func setPhotos() {
        view.setPhotos(photos: photos)
    }
    
    private func setData(product: Product) {
        view.setProductName(name: product.productName)
        view.setDescription(description: product.productDescription)
        view.setPrice(price: "\(product.price) \(currencySign)")
    }
}

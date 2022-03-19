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

protocol CartAddable {
    func addToCart(action: CartAction)
}

class ProductPresenter {
    var view: ProductView
    var factory: RequestFactory
    var coordinator: (Coordinator & ReviewShowable & CartAddable)?
    let productId: UUID
    @UserDefault(key: "authorizationToken", defaultValue: nil) var token: String?

    private var photos = [UIImage]()

    private let currencySign = "₽"

    
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
        let completion = { [weak self] in
            guard let self = self else { return }
            self.view.showAlert("Success!", "Product succesfully added to Cart", nil)
        }
        let onError: (String?) -> Void = {[weak self] errorMessage in
            guard let self = self else { return }
            self.view.showAlert("Error!", errorMessage , nil)
        }
        let cartAction = CartAction(action: .addToCart,
                                    productId: productId,
                                    quantity: 1,
                                    completion: completion,
                                    onError: onError)
        coordinator?.addToCart(action: cartAction)
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

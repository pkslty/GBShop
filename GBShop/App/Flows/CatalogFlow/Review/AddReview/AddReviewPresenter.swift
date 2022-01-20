//
//  AddReviewPresenter.swift
//  GBShop
//
//  Created by Denis Kuzmin on 20.01.2022.
//

import Foundation


class AddReviewPresenter {
    var view: AddReviewView
    var factory: RequestFactory
    var coordinator: (Coordinator)?
    let productId: UUID
    @UserDefault(key: "authorizationToken", defaultValue: nil) var token: String?
    @UserDefault(key: "userId", defaultValue: nil) var userIdString: String?

    var reviews: [Review]?
    var authors: [String]?

    init(factory: RequestFactory, view: AddReviewView, productId: UUID) {
        self.factory = factory
        self.view = view
        self.productId = productId
    }
    
    func load() {
        getProduct {
            self.view.setProductName(name: $0.productName)
        }
    }
    
    func addReviewButtonPressed() {
        if token != nil, let userIdString = userIdString, let userId = UUID(uuidString: userIdString) {
            addReview(userId: userId)
        } else {
            view.showAlert("Warning", "You have to Sign in first") {_ in 
                self.view.close()
            }
        }
    }
    
    private func addReview(userId: UUID) {
        let request = factory.makeReviewsRequestFactory()
        request.addReview(productId: productId, userId: userId, text: view.review, rating: view.rating) { response in
            if let value = response.value {
                DispatchQueue.main.async {
                    switch value.result {
                    case 1:
                        self.view.showAlert("Success", "Review successfully add") {[weak self] _ in
                            guard let self = self else { return }
                            self.view.close()
                        }
                    default:
                        self.view.showAlert("Error", value.errorMessage) {[weak self] _ in
                            guard let self = self else { return }
                            self.view.close()
                        }
                    }
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

}

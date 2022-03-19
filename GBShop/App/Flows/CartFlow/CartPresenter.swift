//
//  CartPresenter.swift
//  GBShop
//
//  Created by Denis Kuzmin on 20.01.2022.
//

import Foundation

enum CartActionType {
    case addToCart
    case removeFromCart
}

struct CartAction {
    let action: CartActionType
    let productId: UUID
    let quantity: Int
    let completion: (() -> Void)?
    let onError: ((String?) -> Void)?
}

class CartPresenter {
    var view: CartView
    var factory: RequestFactory
    var coordinator: Coordinator?
    var cart = [CartItem]()

    @UserDefault(key: "authorizationToken", defaultValue: nil) var token: String?
    @UserDefault(key: "userId", defaultValue: nil) var userIdString: String?
    
    private let currencySign = "₽"
    private let quantityText = "Quantity"
    
    init(factory: RequestFactory, view: CartView) {
        self.factory = factory
        self.view = view
    }
    
    func load() {
        setData(completion: nil)
    }
    
    func getCart(completion: (() -> Void)?, withPhotos: Bool = true) {
        if token != nil, let userIdString = userIdString, let userId = UUID(uuidString: userIdString) {
            let request = factory.makeShoppingRequestFactory()
            request.getCart(userId: userId) { response in
                if let value = response.value {
                    DispatchQueue.main.async {
                        switch value.result {
                        case 1:
                            if let items = value.items {
                                self.cart = items
                                if withPhotos {
                                    self.getPhotos(completion: completion)
                                } else {
                                    self.setData(completion: completion)
                                }
                            }
                        default:
                            self.cart = [CartItem]()
                            self.setData(completion: completion)
                        }
                    }
                }
            }
        } else {
            cart = [CartItem]()
            self.setData(completion: completion)
        }
    }
    

    func addToLocalCart(productId: UUID, quantity: Int, withPhotos: Bool = true, completion: (() -> Void)?, onError: ((String?) -> Void)?) {
        addToRemoteCart(productId: productId, quantity: quantity, withPhotos: withPhotos, completion: completion, onError: onError)
        
    }
    
    func removeFromLocalCart(productId: UUID, quantity: Int, withPhotos: Bool = true, completion: (() -> Void)?, onError: ((String?) -> Void)?) {
        removeFromRemoteCart(productId: productId, quantity: quantity, withPhotos: withPhotos, completion: completion, onError: onError)
    }
    
    func emptyCart(completion: (() -> Void)?) {
        let productsToRemove = cart.map { ($0.product.productId, $0.quantity) }
        productsToRemove.forEach {
            self.removeFromLocalCart(productId: $0.0, quantity: $0.1, withPhotos: false, completion: completion, onError: nil)
        }
    }
    
    func payCart() {
        view.showAlert("Pay Cart", "This alert is showing instead of order flow (Select pay method and pay, delivery addres, etc...)") { _ in
            self.emptyCart { [weak self] in
                guard let self = self else {return }
                self.view.showAlert("Success!", "Successfully payed!", nil)
            }
        }
    }
    
    func viewWillRemoveFromCart(at row: Int) {
        let productId = cart[row].product.productId
        let quantity = cart[row].quantity
        let onError: (String?) -> Void = {[weak self] errorMessage in
            guard let self = self else { return }
            self.view.showAlert("Error!", errorMessage , nil)
        }
        removeFromLocalCart(productId: productId, quantity: quantity, completion: nil, onError: onError)
    }
    
    private func addToRemoteCart(productId: UUID, quantity: Int, withPhotos: Bool = true, completion: (() -> Void)?, onError: ((String?) -> Void)?) {
        guard token != nil, let userIdString = userIdString, let userId = UUID(uuidString: userIdString) else { return }
        let request = factory.makeShoppingRequestFactory()
        request.addToCart(productId: productId, userId: userId, quantity: quantity) { response in
            if let value = response.value {
                DispatchQueue.main.async {
                    switch value.result {
                    case 1:
                        self.getCart(completion: completion, withPhotos: withPhotos)
                    default:
                        onError?(value.errorMessage)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    onError?("Something goes wrong. Can't add to Cart. Please try again later")
                }
            }
        }
    }
    
    private func removeFromRemoteCart(productId: UUID, quantity: Int, withPhotos: Bool = true, completion: (() -> Void)?, onError: ((String?) -> Void)?) {
        guard token != nil, let userIdString = userIdString, let userId = UUID(uuidString: userIdString) else { return }
        let request = factory.makeShoppingRequestFactory()
        request.removeFromCart(productId: productId, userId: userId, quantity: quantity) { response in
            if let value = response.value {
                DispatchQueue.main.async {
                    switch value.result {
                    case 1:
                        self.getCart(completion: completion, withPhotos: withPhotos)
                    default:
                        onError?(value.errorMessage)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    onError?("Something goes wrong. Can't remove from Cart. Please try again later")
                }
            }
        }
    }
    
    private func getPhotos(completion: (() -> Void)? = nil) {
        let request = factory.makeProductsRequestFactory()
        guard cart.count > 0 else {
            self.setData(completion: completion)
            return }
        let group = DispatchGroup()
        for counter in 0 ... cart.count - 1 {
            request.getProductPhotos(productId: cart[counter].product.productId) { response in
                if let value = response.value {
                    group.enter()
                    DispatchQueue.main.async {
                        switch value.result {
                        case 1:
                            if let photoUrlString = value.photos?.first?.urlString {
                                self.cart[counter].product.photoUrlString = photoUrlString
                            }
                            group.leave()
                        default:
                            self.cart[counter].product.photoUrlString = "http://dnk.net.ru/gb_shop/photos/place_holder.png"
                            group.leave()
                        }
                    }
                }
            }
        }
        group.wait()
        self.setData(completion: completion)
    }
    
    private func setData(completion: (() -> Void)?) {
        guard cart.count > 0 else {
            view.setData(list: [CartListItem]())
            completion?()
            return }
        let list = cart.map { (item: CartItem) -> CartListItem in
            let price = "Price: \(item.product.price) \(self.currencySign)"
            let cost = "Cost: \(item.product.price * Double(item.quantity)) \(self.currencySign)"
            return CartListItem(productName: item.product.productName,
                                quantity: "\(quantityText): \(item.quantity) ",
                                price: price,
                                cost: cost,
                                photo: item.product.photoUrlString ?? "http://dnk.net.ru/gb_shop/photos/place_holder.png") }
        view.setData(list: list)
        completion?()
    }
}

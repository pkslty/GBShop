//
//  CartPresenter.swift
//  GBShop
//
//  Created by Denis Kuzmin on 20.01.2022.
//

import Foundation

class CartPresenter {
    var view: CartView
    var factory: RequestFactory
    var coordinator: Coordinator?
    var cart = [CartItem]()

    @UserDefault(key: "authorizationToken", defaultValue: nil) var token: String?
    @UserDefault(key: "userId", defaultValue: nil) var userIdString: String?
    
    let currencySign = "₽"
    
    init(factory: RequestFactory, view: CartView) {
        self.factory = factory
        self.view = view
    }
    
    func load() {
        setData()
    }
    
    func getCart() {
        if token != nil, let userIdString = userIdString, let userId = UUID(uuidString: userIdString) {
            let request = factory.makeShoppingRequestFactory()
            request.getCart(userId: userId) { response in
                if let value = response.value {
                    DispatchQueue.main.async {
                        switch value.result {
                        case 1:
                            if let items = value.items {
                                self.cart = items
                                self.getPhotos()
                                print(items)
                            }
                        default:
                            break
                        }
                    }
                }
            }
        } else {
            cart = [CartItem]()
        }
    }
    
    func addToCart() {
        
    }
    
    func removeFromCart() {
        
    }
    
    private func getPhotos(completion: (() -> Void)? = nil) {
        let request = factory.makeProductsRequestFactory()
        guard cart.count > 0 else { return }
        for counter in 0 ... cart.count - 1 {
            request.getProductPhotos(productId: cart[counter].product.productId) { response in
                if let value = response.value {
                    DispatchQueue.main.async {
                        switch value.result {
                        case 1:
                            if let photoUrlString = value.photos?.first?.urlString {
                                self.cart[counter].product.photoUrlString = photoUrlString
                            }
                        default:
                            self.cart[counter].product.photoUrlString = "http://dnk.net.ru/gb_shop/photos/place_holder.png"
                        }
                    }
                }
            }
        }
        completion?()
    }
    
    private func setData() {
        guard cart.count > 0 else {
            view.setData(list: [CartListItem]())
            return }
        let list = cart.map { (item: CartItem) -> CartListItem in
            let price = "\(item.product.price) \(self.currencySign)"
            let cost = "\(item.product.price * Double(item.quantity)) \(self.currencySign)"
            return CartListItem(productName: item.product.productName,
                                quantity: item.quantity,
                                price: price,
                                cost: cost,
                                photo: item.product.photoUrlString ?? "http://dnk.net.ru/gb_shop/photos/place_holder.png") }
        view.setData(list: list)
    }
}

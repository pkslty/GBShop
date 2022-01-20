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

    @UserDefault(key: "authorizationToken", defaultValue: nil) var token: String?

    init(factory: RequestFactory, view: CartView, productId: UUID) {
        self.factory = factory
        self.view = view
    }
    
    func load() {
        
    }
    

}

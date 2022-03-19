//
//  CartItem.swift
//  GBShop
//
//  Created by Denis Kuzmin on 20.01.2022.
//

import Foundation

struct CartItem: Codable {
    var product: Product
    var quantity: Int
}

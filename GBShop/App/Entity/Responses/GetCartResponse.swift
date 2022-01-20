//
//  GetCartResponse.swift
//  GBShop
//
//  Created by Denis Kuzmin on 20.01.2022.
//

import Foundation

struct GetCartResponse: Codable {
    let result: Int
    let items: [GetCartListItem]?
    let errorMessage: String?
}

struct GetCartListItem: Codable {
    let product: Product
    let quantity: Int
}

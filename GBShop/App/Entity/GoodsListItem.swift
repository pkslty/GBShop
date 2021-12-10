//
//  GoodsListItem.swift
//  GBShop
//
//  Created by Denis Kuzmin on 06.12.2021.
//

import Foundation

struct GoodsListItem: Codable {
    let productId: Int
    let productName: String
    let price: Double
    
    enum CodingKeys: String, CodingKey {
        case productId = "id_product"
        case productName = "product_name"
        case price = "price"
    }
}

extension GoodsListItem: Equatable {
    static func == (lhs: GoodsListItem, rhs: GoodsListItem) -> Bool {
        lhs.productId == rhs.productId &&
        lhs.productName == rhs.productName &&
        lhs.price == rhs.price
    }
}
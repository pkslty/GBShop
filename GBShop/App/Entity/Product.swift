//
//  GoodsListItem.swift
//  GBShop
//
//  Created by Denis Kuzmin on 06.12.2021.
//

import Foundation

struct Product: Codable {
    let productId: UUID
    let productName: String
    let productDescription: String
    let categoryId: UUID
    let brandId: UUID
    let discount: Double
    let quantity: Int
    let rating: Int
    let price: Double
    var photoUrlString: String?
}

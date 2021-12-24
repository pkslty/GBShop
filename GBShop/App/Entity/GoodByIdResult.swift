//
//  GoodByIdResult.swift
//  GBShop
//
//  Created by Denis Kuzmin on 06.12.2021.
//

import Foundation

struct GoodByIdResult: Codable {
    let result: Int
    let productName: String
    let price: Double
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case productName = "product_name"
        case price = "product_price"
        case description = "product_description"
    }
}

extension GoodByIdResult: Equatable {
    static func == (lhs: GoodByIdResult, rhs: GoodByIdResult) -> Bool {
        lhs.result == rhs.result &&
        lhs.productName == rhs.productName &&
        lhs.price == rhs.price &&
        lhs.description == rhs.description
    }
}

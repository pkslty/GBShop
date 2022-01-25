//
//  GoodByIdResult.swift
//  GBShop
//
//  Created by Denis Kuzmin on 06.12.2021.
//

import Foundation

struct ProductByIdResponse: Codable {
    let result: Int
    let product: Product?
    let errorMessage: String?
}

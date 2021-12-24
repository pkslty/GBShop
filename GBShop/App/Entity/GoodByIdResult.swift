//
//  GoodByIdResult.swift
//  GBShop
//
//  Created by Denis Kuzmin on 06.12.2021.
//

import Foundation

struct GoodByIdResult: Codable {
    let result: Int
    let productName: String?
    let price: Double?
    let description: String?
    let errorMessage: String?
}

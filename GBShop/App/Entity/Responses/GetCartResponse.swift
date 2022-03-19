//
//  GetCartResponse.swift
//  GBShop
//
//  Created by Denis Kuzmin on 20.01.2022.
//

import Foundation

struct GetCartResponse: Codable {
    let result: Int
    let items: [CartItem]?
    let errorMessage: String?
}

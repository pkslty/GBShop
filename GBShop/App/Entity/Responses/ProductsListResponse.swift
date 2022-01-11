//
//  ProductsListResponse.swift
//  GBShop
//
//  Created by Denis Kuzmin on 11.01.2022.
//

import Foundation

struct ProductsListResponse: Codable {
    let result: Int
    let items: [ListItem]?
    let errorMessage: String?
}

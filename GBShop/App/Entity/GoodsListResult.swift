//
//  GoodsListResult.swift
//  GBShop
//
//  Created by Denis Kuzmin on 14.12.2021.
//

import Foundation

struct GoodsListResult: Codable {
    let result: Int
    let pageNumber: Int?
    let products: [GoodsListItem]?
    let errorMessage: String?
}

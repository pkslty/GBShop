//
//  ListResponse.swift
//  GBShop
//
//  Created by Denis Kuzmin on 11.01.2022.
//

import Foundation

struct GetListResponse: Codable {
    let result: Int
    let items: [ProductListItem]?
    let errorMessage: String?
}

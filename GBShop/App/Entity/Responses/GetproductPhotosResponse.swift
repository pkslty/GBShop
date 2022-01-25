//
//  GetproductPhotosResponse.swift
//  GBShop
//
//  Created by Denis Kuzmin on 17.01.2022.
//

import Foundation

struct GetProductPhotosResponse: Codable {
    let result: Int
    let photos: [ProductPhoto]?
    let errorMessage: String?
}

struct ProductPhoto: Codable {
    let urlString: String
}

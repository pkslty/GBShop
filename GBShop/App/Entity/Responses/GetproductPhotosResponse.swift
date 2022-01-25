//
//  GetproductPhotosResponse.swift
//  GBShop
//
//  Created by Denis Kuzmin on 17.01.2022.
//

import Foundation

struct GePhotosResponse: Codable {
    let result: Int
    let photos: [PhotoPath]?
    let errorMessage: String?
}

struct PhotoPath: Codable {
    let urlString: String
}

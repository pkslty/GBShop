//
//  GetBrandByIdResponse.swift
//  GBShop
//
//  Created by Denis Kuzmin on 13.01.2022.
//

import Foundation

struct GetBrandByIdResponse: Codable {
    let result: Int
    let brand: Brand?
    let errorMessage: String?
}

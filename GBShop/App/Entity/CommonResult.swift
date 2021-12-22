//
//  CommonResult.swift
//  GBShop
//
//  Created by Denis Kuzmin on 10.12.2021.
//

import Foundation

struct CommonResult: Codable, Equatable {
    let result: Int
    let userMessage: String?
    let errorMessage: String?
}

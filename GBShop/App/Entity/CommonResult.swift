//
//  CommonResult.swift
//  GBShop
//
//  Created by Denis Kuzmin on 10.12.2021.
//

import Foundation

struct CommonResult: Codable {
    let result: Int
    let userMessage: String?
    let errorMessage: String?
}

extension CommonResult: Equatable {
    static func == (lhs: CommonResult, rhs: CommonResult) -> Bool {
        lhs.result == rhs.result &&
        lhs.userMessage == rhs.userMessage &&
        lhs.errorMessage == rhs.errorMessage
    }
}


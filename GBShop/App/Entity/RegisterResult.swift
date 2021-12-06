//
//  RegisterResult.swift
//  GBShop
//
//  Created by Denis Kuzmin on 01.12.2021.
//

import Foundation

struct RegisterResult: Codable {
    let result: Int
    let userMessage: String
}

extension RegisterResult: Equatable {
    static func == (lhs: RegisterResult, rhs: RegisterResult) -> Bool {
        lhs.result == rhs.result &&
        lhs.userMessage == rhs.userMessage
    }
}

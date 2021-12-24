//
//  LoginResult.swift
//  GBShop
//
//  Created by Denis Kuzmin on 01.12.2021.
//

import Foundation

struct LoginResult: Codable {
    let result: Int
    let user: UserResult
    let authToken: String
}

extension LoginResult: Equatable {
    static func == (lhs: LoginResult, rhs: LoginResult) -> Bool {
        lhs.result == rhs.result &&
        lhs.user == rhs.user &&
        lhs.authToken == rhs.authToken
    }
    
    
}

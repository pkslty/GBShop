//
//  LoginResult.swift
//  GBShop
//
//  Created by Denis Kuzmin on 01.12.2021.
//

import Foundation

struct LoginResult: Codable {
    let result: Int
    let user: User?
    let errorMessage: String?
}

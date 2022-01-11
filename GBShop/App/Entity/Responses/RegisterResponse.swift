//
//  RegisterResult.swift
//  GBShop
//
//  Created by Denis Kuzmin on 01.12.2021.
//

import Foundation

struct RegisterResponse: Codable {
    let result: Int
    let userMessage: String
}

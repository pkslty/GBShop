//
//  User.swift
//  GBShop
//
//  Created by Denis Kuzmin on 02.12.2021.
//

import Foundation

struct User: Codable {
    let id: Int
    let login: String
    let name: String
    let lastname: String
    let password: String
    let email: String
    let gender: String
    let creditCard: String
    let bio: String
}

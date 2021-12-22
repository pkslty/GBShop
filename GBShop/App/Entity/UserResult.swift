//
//  User.swift
//  GBShop
//
//  Created by Denis Kuzmin on 01.12.2021.
//

import Foundation

struct UserResult: Codable {
    let id: Int
    let login: String
    let name: String?
    let lastname: String?
    let email: String
    let gender: String?
    let creditCard: String?
    let bio: String?
}



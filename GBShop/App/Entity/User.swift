//
//  User.swift
//  GBShop
//
//  Created by Denis Kuzmin on 02.12.2021.
//

import Foundation

struct User: Codable {
    let id: UUID
    let username: String
    let name: String?
    let middleName: String?
    let lastName: String?
    let password: String
    let email: String
    let gender: String?
    let creditCardId: String?
    let bio: String?
    let token: String?
    let photoUrlString: String?
}

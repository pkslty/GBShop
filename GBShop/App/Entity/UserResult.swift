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
    let name: String
    let lastname: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id_user"
        case login = "user_login"
        case name = "user_name"
        case lastname = "user_lastname"
    }
}

extension UserResult: Equatable {
    static func == (lhs: UserResult, rhs: UserResult) -> Bool {
        lhs.id == rhs.id &&
        lhs.login == rhs.login &&
        lhs.name == rhs.name &&
        lhs.lastname == rhs.lastname
    }
}

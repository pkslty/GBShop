//
//  User.swift
//  GBShop
//
//  Created by Denis Kuzmin on 01.12.2021.
//

import Foundation

struct UserResult: Codable {
    let id: UUID
    let login: String
    let name: String?
    let lastname: String?
    let email: String
    let gender: String?
    let creditCard: String?
    let bio: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case name
        case lastname
        case email
        case gender
        case creditCard
        case bio
    }
}

extension UserResult: Equatable {
    static func == (lhs: UserResult, rhs: UserResult) -> Bool {
        lhs.id == rhs.id &&
        lhs.login == rhs.login &&
        lhs.name == rhs.name &&
        lhs.lastname == rhs.lastname &&
        lhs.email == rhs.email &&
        lhs.gender == rhs.gender &&
        lhs.creditCard == rhs.creditCard &&
        lhs.bio == rhs.bio
    }
}



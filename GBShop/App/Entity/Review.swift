//
//  Review.swift
//  GBShop
//
//  Created by Denis Kuzmin on 15.12.2021.
//

import Foundation

struct Review: Codable {    
    let id: Int
    let productId: Int
    let userId: Int
    let text: String
    let rating: Int
    let likes: Int
}

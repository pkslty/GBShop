//
//  ListItem.swift
//  GBShop
//
//  Created by Denis Kuzmin on 11.01.2022.
//

import Foundation

struct ProductListItem: Codable {
    let id: UUID
    let name: String
    let description: String
}

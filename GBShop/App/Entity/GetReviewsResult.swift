//
//  GetReviewsResult.swift
//  GBShop
//
//  Created by Denis Kuzmin on 15.12.2021.
//

import Foundation

struct GetReviewsResult: Codable {
    let result: Int
    let reviews: [Review]?
    let errorMessage: String?
}

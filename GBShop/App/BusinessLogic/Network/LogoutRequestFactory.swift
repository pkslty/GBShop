//
//  LogoutRequestFactory.swift
//  GBShop
//
//  Created by Denis Kuzmin on 02.12.2021.
//

import Alamofire
import Foundation

protocol LogoutRequestFactory {
    func logout(userId: Int,
                  completionHandler: @escaping (AFDataResponse<PositiveResult>) -> Void)
}

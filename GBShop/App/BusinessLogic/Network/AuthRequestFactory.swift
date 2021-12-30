//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Denis Kuzmin on 01.12.2021.
//

import Alamofire
import Foundation

protocol AuthRequestFactory {
    func login(username: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
    func logout(token: String, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void)
}

//
//  RegisterRequestFactory.swift
//  GBShop
//
//  Created by Denis Kuzmin on 01.12.2021.
//

import Alamofire
import Foundation

protocol RegistrationRequestFactory {
    func register(userId: Int,
                  userName: String,
                  password: String,
                  email: String,
                  gender: String,
                  creditCard: String,
                  bio: String,
                  completionHandler: @escaping (AFDataResponse<RegisterResult>) -> Void)
    
    func changeUserData(userId: Int,
                  userName: String,
                  password: String,
                  email: String,
                  gender: String,
                  creditCard: String,
                  bio: String,
                  completionHandler: @escaping (AFDataResponse<PositiveResult>) -> Void)
}

//
//  RegisterRequestFactory.swift
//  GBShop
//
//  Created by Denis Kuzmin on 01.12.2021.
//

import Alamofire
import Foundation

protocol RegistrationRequestFactory {
    func register(user: User,
                  completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void)
    
    func changeUserData(user: User,
                  completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void)
    func getUserData(token: String, completionHandler: @escaping (AFDataResponse<LoginResponse>) -> Void)
}

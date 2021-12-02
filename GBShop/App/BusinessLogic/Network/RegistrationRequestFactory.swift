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
                  completionHandler: @escaping (AFDataResponse<RegisterResult>) -> Void)
    
    func changeUserData(user: User,
                  completionHandler: @escaping (AFDataResponse<PositiveResult>) -> Void)
}

//
//  Registration.swift
//  GBShop
//
//  Created by Denis Kuzmin on 01.12.2021.
//

import Alamofire
import Foundation

class Registration: AbstractRequestFactory {
    
    var errorParser: AbstractErrorParser
    var sessionManager: Session
    var queue: DispatchQueue
    let baseUrl = URL(string: "https://vast-hollows-60312.herokuapp.com/")!
    //let baseUrl = URL(string: "http://127.0.0.1:8080/")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Registration: RegistrationRequestFactory {
    
    func register(user: User, completionHandler: @escaping (AFDataResponse<RegisterResult>) -> Void) {
        let requestModel = UserData(baseUrl: baseUrl, path: "register", user: user)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func changeUserData(user: User, completionHandler: @escaping (AFDataResponse<PositiveResult>) -> Void) {
        let requestModel = UserData(baseUrl: baseUrl, path: "changeUserData", user: user)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    
}

extension Registration {
    struct UserData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        var path: String
        
        let user: User
        var parameters: Parameters? {
            return [
                "id": user.id,
                "login": user.login,
                "password": user.password,
                "name": user.name,
                "lastname": user.lastname,
                "email": user.email,
                "gender": user.gender,
                "creditcard": user.creditCard,
                "bio": user.bio
            ]
        }
    }
}

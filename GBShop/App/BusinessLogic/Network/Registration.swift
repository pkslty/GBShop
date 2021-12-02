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
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    
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
        let requestModel = UserData(baseUrl: baseUrl, path: "registerUser.json", user: user)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func changeUserData(user: User, completionHandler: @escaping (AFDataResponse<PositiveResult>) -> Void) {
        let requestModel = UserData(baseUrl: baseUrl, path: "changeUserData.json", user: user)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    
}

extension Registration {
    struct UserData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        var path: String
        
        let user: User
        var parameters: Parameters? {
            return [
                "id_user": user.id,
                "username": user.login,
                "password": user.password,
                "email": user.email,
                "gender": user.gender,
                "creditCard": user.creditCard,
                "bio": user.bio
            ]
        }
    }
}

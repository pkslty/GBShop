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
    func getUserData(token: String, completionHandler: @escaping (AFDataResponse<LoginResponse>) -> Void) {
        let requestModel = UserData(baseUrl: baseUrl, path: "getUserData", token: token)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func register(user: User, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void) {
        let requestModel = UserData(baseUrl: baseUrl, path: "register", user: user)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func changeUserData(user: User, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void) {
        let requestModel = UserData(baseUrl: baseUrl, path: "changeUserData", user: user)
        print(requestModel)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    
}

extension Registration {
    struct UserData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        var path: String
        
        let user: User?
        var token: String? = nil
        var parameters: Parameters? {
            if let user = user {
                var parameters = Parameters()
                parameters["id"] = user.id
                parameters["username"] = user.username
                if let password = user.password { parameters["password"] = password }
                if let name = user.name { parameters["name"] = name }
                if let middleName = user.middleName { parameters["middleName"] = middleName }
                if let lastName = user.lastName { parameters["lastName"] = lastName }
                parameters["email"] = user.email
                if let gender = user.gender { parameters["gender"] = gender }
                if let creditCardId = user.creditCardId { parameters["creditCardId"] = creditCardId }
                if let token = user.token { parameters["token"] = token }
                if let bio = user.bio { parameters["bio"] = bio }
                if let photoUrlString = user.photoUrlString { parameters["photoUrlString"] = photoUrlString }
                return parameters
            } else {
                if let token = token {
                    return [
                        "token": token
                        ]
                } else {
                    return [:]
                }
            }
        }
        
        init(baseUrl: URL, path: String, user: User) {
            self.baseUrl = baseUrl
            self.path = path
            self.user = user
        }
        
        init(baseUrl: URL, path: String, token: String) {
            self.baseUrl = baseUrl
            self.path = path
            self.token = token
            self.user = nil
        }
    }
}

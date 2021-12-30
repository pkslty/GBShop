//
//  Auth.swift
//  GBShop
//
//  Created by Denis Kuzmin on 01.12.2021.
//

import Alamofire
import Foundation

class Auth: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    //let baseUrl = URL(string: "https://vast-hollows-60312.herokuapp.com/")!
    let baseUrl = URL(string: "http://127.0.0.1:8080/")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Auth: AuthRequestFactory {
    func login(username: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, path: "login", username: username, password: password, token: nil)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func logout(token: String, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, path: "logout", username: nil, password: nil, token: token)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Auth {
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String
        
        let username: String?
        let password: String?
        let token: String?
        var parameters: Parameters? {
            var parameters: Parameters?
            if let token = token {
                parameters =  [
                    "token": token,
                ]
            }
            if let username = username, let password = password {
                parameters = [
                    "username": username,
                    "password": password
                ]
            }
            return parameters
        }
    }
}

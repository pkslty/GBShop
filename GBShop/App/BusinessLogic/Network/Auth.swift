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

extension Auth: AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, path: "login", userId: nil, login: userName, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func logout(userId: Int, completionHandler: @escaping (AFDataResponse<CommonResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, path: "logout", userId: userId, login: nil, password: nil)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Auth {
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String
        
        let userId: Int?
        let login: String?
        let password: String?
        var parameters: Parameters? {
            var parameters: Parameters?
            if let userId = userId {
                parameters =  [
                    "id": userId,
                ]
            }
            if let login = login, let password = password {
                parameters = [
                    "login": login,
                    "password": password
                ]
            }
            return parameters
        }
    }
}

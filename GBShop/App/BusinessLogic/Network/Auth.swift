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

extension Auth: AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, path: "login.json", userId: nil, login: userName, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func logout(userId: Int, completionHandler: @escaping (AFDataResponse<PositiveResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, path: "logout.json", userId: userId, login: nil, password: nil)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Auth {
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String
        
        let userId: Int?
        let login: String?
        let password: String?
        var parameters: Parameters? {
            var parameters: Parameters?
            if let userId = userId {
                parameters =  [
                    "id_user": userId,
                ]
            }
            if let login = login, let password = password {
                parameters = [
                    "username": login,
                    "password": password
                ]
            }
            return parameters
        }
    }
}

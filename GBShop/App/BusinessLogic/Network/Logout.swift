//
//  Logout.swift
//  GBShop
//
//  Created by Denis Kuzmin on 02.12.2021.
//

import Alamofire
import Foundation

class Logout: AbstractRequestFactory {
    
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

extension Logout: LogoutRequestFactory {
    
    func logout(userId: Int, completionHandler: @escaping (AFDataResponse<PositiveResult>) -> Void) {
        let requestModel = Logout(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    
}

extension Logout {
    struct Logout: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "registerUser.json"
        
        let userId: Int
        var parameters: Parameters? {
            return [
                "id_user": userId,
            ]
        }
    }
}


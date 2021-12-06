//
//  RequestFactory.swift
//  GBShop
//
//  Created by Denis Kuzmin on 01.12.2021.
//

import Alamofire
import Foundation

class RequestFactory {
    
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager
    }()
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makeAuthRequestFactory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return Auth(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeRegistrationRequestFactory() -> RegistrationRequestFactory {
        let errorParser = makeErrorParser()
        return Registration(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeGoodsRequestFactory() -> GoodsRequestFactory {
        let errorParser = makeErrorParser()
        return Goods(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
}

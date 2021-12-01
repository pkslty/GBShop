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
    
    func makeAuthRequestFatory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return Auth(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeRegisterRequestFatory() -> RegistrationRequestFactory {
        let errorParser = makeErrorParser()
        return Registration(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
}

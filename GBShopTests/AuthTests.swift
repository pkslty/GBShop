//
//  AuthTest.swift
//  GBShopTests
//
//  Created by Denis Kuzmin on 06.12.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class AuthTests: XCTestCase {
    
    let expectations = [XCTestExpectation(description: "User login"),
                        XCTestExpectation(description: "User logout")]
    var errorParser: ErrorParserStub!

    enum ApiErrorStub: Error {
        case fatalError
    }

    struct ErrorParserStub: AbstractErrorParser {
        func parse(_ result: Error) -> Error {
            return ApiErrorStub.fatalError
        }
        
        func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
            return error
        }
    }

    override func setUpWithError() throws {
        
        errorParser = ErrorParserStub()

    }

    override func tearDownWithError() throws {
        
        errorParser = nil
        
    }
    
    func testLogin() {
        
        let errorParser = ErrorParserStub()
        
        let session: Session = {
            let configuration = URLSessionConfiguration.default
            configuration.httpShouldSetCookies = false
            configuration.headers = .default
            let manager = Session(configuration: configuration)
            return manager
        }()
        let queue = DispatchQueue.global(qos: .utility)
        
        let auth = Auth(errorParser: errorParser, sessionManager: session, queue: queue)
    
        let successValue = LoginResult(result: 1,
                                       user: UserResult(id: 123,
                                                        login: "geekbrains",
                                                        name: "John",
                                                        lastname: "Doe"),
                                       authToken: "some_authorizaion_token")
        auth.login(userName: "", password: "") { result in
            guard let value = result.value, value == successValue else {
                XCTFail()
                return
            }
            self.expectations[0].fulfill()
        }
        wait(for: [expectations[0]], timeout: 10.0)
    }
    
    func testLogout() {
        
        let errorParser = ErrorParserStub()
        
        let session: Session = {
            let configuration = URLSessionConfiguration.default
            configuration.httpShouldSetCookies = false
            configuration.headers = .default
            let manager = Session(configuration: configuration)
            return manager
        }()
        let queue = DispatchQueue.global(qos: .utility)
        
        let auth = Auth(errorParser: errorParser, sessionManager: session, queue: queue)
    
        let successValue = PositiveResult(result: 1)
        auth.logout(userId: 123) { result in
            guard let value = result.value, value == successValue else {
                XCTFail()
                return
            }
            self.expectations[1].fulfill()
        }
        wait(for: [expectations[1]], timeout: 10.0)
    }


}


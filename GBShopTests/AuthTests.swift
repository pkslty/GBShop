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
    
    var requestFactory: RequestFactory!

    override func setUp() {
        requestFactory = RequestFactory()
    }

    override func tearDown() {
        
        requestFactory = nil
        
    }
    
    func testLogin() {
                
        
        let expectation = expectation(description: "User log in")
        
        let request = requestFactory.makeAuthRequestFactory()
        @UserDefault(key: "authorizationToken", defaultValue: nil) var token: String?
        print("token is \(token ?? "nil") ")
        request.login(username: "22DFF4F8-E6C8-4945-A12C-2C225A456CB8", password: "mypassword") { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, 1)
                XCTAssertNotNil(result.user)
                XCTAssertNil(result.errorMessage)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLogoutSuccess() {
        
        let successValue = DefaultResponse(result: 1,
                                        userMessage: "Succesfully logged out!",
                                        errorMessage: nil)
        let expectation = expectation(description: "User log out")
        
        let request = requestFactory.makeAuthRequestFactory()
        
        @UserDefault(key: "authorizationToken", defaultValue: nil) var token: String?
        print("token is \(token ?? "nil")")
        
        request.logout(token: "eed87e91fbdd0784f63fe201de58ae5d") { response in
            switch response.result {
            case .success(let result):
                token = nil
                print("token is \(token ?? "nil")")
                XCTAssertEqual(result, successValue)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLogoutNoSuchUser() {
        
        let successValue = DefaultResponse(result: 0,
                                        userMessage: nil,
                                        errorMessage: "No such user")
        let expectation = expectation(description: "User log out")
        
        let request = requestFactory.makeAuthRequestFactory()
        
        request.logout(token: "token") { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result, successValue)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }


}


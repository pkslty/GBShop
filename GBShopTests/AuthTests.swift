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
        request.login(userName: "Somebody", password: "mypassword") { response in
            switch response.result {
            case .success(let result):
                token = result.token
                print("token is \(token ?? "nil")")
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
        
        let successValue = CommonResult(result: 1,
                                        userMessage: "Succesfully logged out!",
                                        errorMessage: nil)
        let expectation = expectation(description: "User log out")
        
        let request = requestFactory.makeAuthRequestFactory()
        
        @UserDefault(key: "authorizationToken", defaultValue: nil) var token: String?
        print("token is \(token ?? "nil")")
        
        request.logout(userId: 2) { response in
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
        
        let successValue = CommonResult(result: 0,
                                        userMessage: nil,
                                        errorMessage: "No such user")
        let expectation = expectation(description: "User log out")
        
        let request = requestFactory.makeAuthRequestFactory()
        
        request.logout(userId: -1) { response in
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
    
    func testLogoutUserWasNotLoggedIn() {
        
        let successValue = CommonResult(result: 0,
                                        userMessage: nil,
                                        errorMessage: "User was not logged in")
        let expectation = expectation(description: "User was not logged in")
        
        let request = requestFactory.makeAuthRequestFactory()
        
        request.logout(userId: 1) { response in
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


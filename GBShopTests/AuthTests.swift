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
                
        let successValue = LoginResult(result: 1,
                                       user: UserResult(id: 123,
                                                        login: "geekbrains",
                                                        name: "John",
                                                        lastname: "Doe"),
                                       authToken: "some_authorizaion_token")
        let expectation = expectation(description: "User log in")
        
        let request = requestFactory.makeAuthRequestFactory()
        
        request.login(userName: "Somebody", password: "mypassword") { response in
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
    
    func testLogout() {
        
        let successValue = PositiveResult(result: 1)
        let expectation = expectation(description: "User log out")
        
        let request = requestFactory.makeAuthRequestFactory()
        
        request.logout(userId: 123) { response in
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


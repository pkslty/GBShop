//
//  RegistrationTests.swift
//  GBShopTests
//
//  Created by Denis Kuzmin on 06.12.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class RegistrationTests: XCTestCase {
    
    var requestFactory: RequestFactory!
    let user = User(id: UUID(),
                    username: "Somebody",
                    name: "John",
                    middleName: "",
                    lastName: "Doe",
                    password: "mypassword",
                    email: "some@some.ru",
                    gender: "m",
                    creditCardId: "9872389-2424-234224-234",
                    bio: "This is good! I think I will switch to another language",
                    token: "",
                    photoUrlString: "")

    override func setUp() {
        requestFactory = RequestFactory()
    }

    override func tearDown() {
        
        requestFactory = nil
        
    }
    
    func testRegisterSuccess() {
                
        let successValue = DefaultResponse(result: 1,
                                        userMessage: "Succesfully register!",
                                        errorMessage: nil)
        
        let newUser = User(id: UUID(),
                           username: UUID().uuidString,
                           name: "John",
                           middleName: "",
                           lastName: "Doe",
                           password: "mypassword",
                           email: UUID().uuidString,
                           gender: "m",
                           creditCardId: "9872389-2424-234224-234",
                           bio: "This is good! I think I will switch to another language",
                           token: "",
                           photoUrlString: "")
        
        
        let expectation = expectation(description: "User registered")
        
        let request = requestFactory.makeRegistrationRequestFactory()
        
        request.register(user: newUser) { response in
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
    
    func testRegisterReject() {
                
        let successValue = DefaultResponse(result: 0,
                                        userMessage: nil,
                                        errorMessage: "Error: username or e-mail already exists")
        
        
        let expectation = expectation(description: "User already exists")
        
        let request = requestFactory.makeRegistrationRequestFactory()
        
        request.register(user: user) { response in
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
    
    func testchangeUserData() {

        let changeUser = User(id: UUID(),
                              username: UUID().uuidString,
                              name: "John",
                              middleName: "",
                              lastName: "Doe",
                              password: "mypassword",
                              email: UUID().uuidString,
                              gender: "m",
                              creditCardId: "9872389-2424-234224-234",
                              bio: "This is good! I think I will switch to another language",
                              token: "9eb3522128ffe2d1d2c46771460ce352",
                              photoUrlString: "")
        
        let successValue = DefaultResponse(result: 1,
                                        userMessage: "Succesfully changed user data!",
                                        errorMessage: nil)
        let expectation = expectation(description: "User changes data")
        
        let request = requestFactory.makeRegistrationRequestFactory()
        
        request.changeUserData(user: changeUser) { response in
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

    func testGetUserData() {
        
        let successValue = 1
        let expectation = expectation(description: "GetUserData")
        
        let request = requestFactory.makeRegistrationRequestFactory()
        let token = "9eb3522128ffe2d1d2c46771460ce352"
        
        request.getUserData(token: token) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, successValue)
                XCTAssertNotNil(result.user)
                XCTAssertNil(result.errorMessage)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }

}



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
    let user = User(id: 2,
                    login: "Somebody",
                    name: "John",
                    lastname: "Doe",
                    password: "mypassword",
                    email: "some@some.ru",
                    gender: "m",
                    creditCard: "9872389-2424-234224-234",
                    bio: "This is good! I think I will switch to another language")

    override func setUp() {
        requestFactory = RequestFactory()
    }

    override func tearDown() {
        
        requestFactory = nil
        
    }
    
    func testRegisterSuccess() {
                
        let successValue = CommonResult(result: 1,
                                        userMessage: "Регистрация прошла успешно!",
                                        errorMessage: nil)
        
        let newUser = User(id: 2,
                           login: UUID().uuidString,
                        name: "John",
                        lastname: "Doe",
                        password: "mypassword",
                           email: UUID().uuidString,
                        gender: "m",
                        creditCard: "9872389-2424-234224-234",
                        bio: "This is good! I think I will switch to another language")
        
        
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
                
        let successValue = CommonResult(result: 0,
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
        
        let successValue = CommonResult(result: 1,
                                        userMessage: "Succesfully changed user data!",
                                        errorMessage: nil)
        let expectation = expectation(description: "User changes data")
        
        let request = requestFactory.makeRegistrationRequestFactory()
        
        request.changeUserData(user: user) { response in
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


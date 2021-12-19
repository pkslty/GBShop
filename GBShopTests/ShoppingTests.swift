//
//  ShoppingTests.swift
//  GBShopTests
//
//  Created by Denis Kuzmin on 16.12.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class ShoppingTests: XCTestCase {
    
    var requestFactory: RequestFactory!

    override func setUp() {
        requestFactory = RequestFactory()
    }

    override func tearDown() {
        
        requestFactory = nil
        
    }
    
    func testAddToCart() {
                
        let successValue = 1
        let expectation = expectation(description: "AddToCart")
        
        let request = requestFactory.makeShoppingRequestFactory()
        
        request.addToCart(productId: 1, userId: 1, quantity: 1) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, successValue)
                XCTAssertNotNil(result.userMessage)
                XCTAssertNil(result.errorMessage)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testRemoveFromCart() {
                
        let successValue = 1
        let expectation = expectation(description: "RemoveFromCart")
        
        let request = requestFactory.makeShoppingRequestFactory()
        
        request.removeFromCart(productId: 1, userId: 3, quantity: 1) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, successValue)
                XCTAssertNotNil(result.userMessage)
                XCTAssertNil(result.errorMessage)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPayCartSuccess() {
        
        let successValue = 1
        let expectation = expectation(description: "payCartSuccess")
        
        let request = requestFactory.makeShoppingRequestFactory()
        
        request.payCart(userId: 1) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, successValue)
                XCTAssertNotNil(result.userMessage)
                XCTAssertNil(result.errorMessage)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPayCartWrongQuantity() {
        
        let successValue = 0
        let expectation = expectation(description: "payCartWrongQuantity")
        
        let request = requestFactory.makeShoppingRequestFactory()
        
        request.payCart(userId: 3) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, successValue)
                XCTAssertNil(result.userMessage)
                XCTAssertNotNil(result.errorMessage)
                XCTAssertEqual(result.errorMessage, "Wrong quantity")
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPayCartEmptyCart() {
        
        let successValue = 0
        let expectation = expectation(description: "payCartEmptyCart")
        
        let request = requestFactory.makeShoppingRequestFactory()
        
        request.payCart(userId: 10) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, successValue)
                XCTAssertNil(result.userMessage)
                XCTAssertNotNil(result.errorMessage)
                XCTAssertEqual(result.errorMessage, "The Cart is empty")
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
}

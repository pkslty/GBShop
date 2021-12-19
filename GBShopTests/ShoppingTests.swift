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
    
    func testPayCart() {
        
        let successValue = 1
        let expectation = expectation(description: "payCart")
        
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
}

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
        
        request.addToCart(productId: UUID(uuidString: "145ec120-725a-11ec-b7a6-0800200c9a66")!, userId: UUID(uuidString: "14db332d-1052-4579-aed9-b4cb47164a8f")!, quantity: 1) { response in
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
        
        request.removeFromCart(productId: UUID(uuidString: "145ec120-725a-11ec-b7a6-0800200c9a66")!, userId: UUID(uuidString: "0336ccd3-9c1b-456f-a27f-ba711fb70415")!, quantity: 1) { response in
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
        
        request.payCart(userId: UUID(uuidString: "14db332d-1052-4579-aed9-b4cb47164a8f")!) { response in
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
        
        request.payCart(userId: UUID(uuidString: "1ea24a07-9f12-4efa-8090-1b27c6afadcf")!) { response in
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
        
        request.payCart(userId: UUID()) { response in
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
    
    func testGetCartSuccess() {
        
        let successValue = 1
        let expectation = expectation(description: "getCartSuccess")
        
        let request = requestFactory.makeShoppingRequestFactory()
        
        request.getCart(userId: UUID(uuidString: "0336ccd3-9c1b-456f-a27f-ba711fb70415")!) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, successValue)
                XCTAssertNotNil(result.items)
                XCTAssertNil(result.errorMessage)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
}

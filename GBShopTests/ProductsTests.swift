//
//  GoodsTests.swift
//  GBShopTests
//
//  Created by Denis Kuzmin on 06.12.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class ProductsTests: XCTestCase {
    
    var requestFactory: RequestFactory!

    override func setUp() {
        requestFactory = RequestFactory()
    }

    override func tearDown() {
        
        requestFactory = nil
        
    }
    
    func testGetGoodById() {
                
        let successValue = 1
        let expectation = expectation(description: "GetProductById")
        
        let request = requestFactory.makeProductsRequestFactory()
        
        request.getProductById(id: 1) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, successValue)
                XCTAssertNotNil(result.description)
                XCTAssertNotNil(result.price)
                XCTAssertNotNil(result.productName)
                XCTAssertNil(result.errorMessage)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetGoodsByIdFail() {
                
        let successValue = 0
        let expectation = expectation(description: "GetProductByIdFail")
        
        let request = requestFactory.makeProductsRequestFactory()
        
        request.getProductById(id: -1) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, successValue)
                XCTAssertNotNil(result.errorMessage)
                XCTAssertNil(result.description)
                XCTAssertNil(result.price)
                XCTAssertNil(result.productName)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetGoodsList() {
        
        let successValue = 1
        let expectation = expectation(description: "GetProductsList")
        
        let request = requestFactory.makeProductsRequestFactory()
        
        request.getProductsList(page: 1, categoryId: 1) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, successValue)
                XCTAssertNotNil(result.products)
                XCTAssertNil(result.errorMessage)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
}

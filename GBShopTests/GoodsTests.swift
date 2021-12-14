//
//  GoodsTests.swift
//  GBShopTests
//
//  Created by Denis Kuzmin on 06.12.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class GoodsTests: XCTestCase {
    
    var requestFactory: RequestFactory!

    override func setUp() {
        requestFactory = RequestFactory()
    }

    override func tearDown() {
        
        requestFactory = nil
        
    }
    
    func testGetGoodById() {
                
        let successValue = 1
        let expectation = expectation(description: "GetGoodById")
        
        let request = requestFactory.makeGoodsRequestFactory()
        
        request.getGoodById(id: 1) { response in
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
        let expectation = expectation(description: "GetGoodByIdFail")
        
        let request = requestFactory.makeGoodsRequestFactory()
        
        request.getGoodById(id: -1) { response in
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
        let expectation = expectation(description: "GetGoodsList")
        
        let request = requestFactory.makeGoodsRequestFactory()
        
        request.getGoodsList(page: 1, categoryId: 1) { response in
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

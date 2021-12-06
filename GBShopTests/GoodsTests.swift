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
    
    func testGetGoodsById() {
                
        let successValue = GoodByIdResult(result: 1,
                                          productName: "Ноутбук",
                                          price: 45600,
                                          description: "Мощный игровой ноутбук")
        let expectation = expectation(description: "GetGoodById")
        
        let request = requestFactory.makeGoodsRequestFactory()
        
        request.getGoodById(id: 123) { response in
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
    
    func testGetGoodsList() {
        
        let successValue = [GoodsListItem(productId: 123,
                                          productName: "Ноутбук",
                                          price: 45600),
                            GoodsListItem(productId: 456,
                                          productName: "Мышка",
                                          price: 1000)]
        let expectation = expectation(description: "GetGoodsList")
        
        let request = requestFactory.makeGoodsRequestFactory()
        
        request.getGoodsList(page: 1, categoryId: 1) { response in
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

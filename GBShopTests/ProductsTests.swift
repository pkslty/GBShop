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
        
        request.getProductById(id: UUID(uuidString: "e6581c80-725a-11ec-b7a6-0800200c9a66")!) { response in
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
        
        request.getProductById(id: UUID(uuidString: "e6581c80-725a-11ec-b7a6-0800200c9a60")!) { response in
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
        
        request.getProductsList(page: 1, categoryId: UUID(uuidString: "cb0b2700-723d-11ec-b7a6-0800200c9a66")!) { response in
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
    
    func testGetCategories() {
        
        let successValue = 1
        let expectation = expectation(description: "GetCategories")
        
        let request = requestFactory.makeProductsRequestFactory()
        
        request.getCategories() { response in
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
    
    func testGetBrands() {
        
        let successValue = 1
        let expectation = expectation(description: "GetBrands")
        
        let request = requestFactory.makeProductsRequestFactory()
        
        request.getCategories() { response in
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
    
    func testGetBrandCategories() {
        
        let successValue = 1
        let expectation = expectation(description: "GetBrandCategories")
        
        let request = requestFactory.makeProductsRequestFactory()
        
        request.getBrandCategories(brandId: UUID(uuidString: "ee861fc0-7245-11ec-b7a6-0800200c9a66")!) { response in
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
    
    func testGetBrandById() {
        
        let successValue = 1
        let expectation = expectation(description: "GetBrandById")
        
        let request = requestFactory.makeProductsRequestFactory()
        
        request.getBrandById(brandId: UUID(uuidString: "ee861fc0-7245-11ec-b7a6-0800200c9a66")!) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, successValue)
                XCTAssertNotNil(result.brand)
                XCTAssertNil(result.errorMessage)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetProductPhotos() {
        
        let successValue = 1
        let expectation = expectation(description: "GetProductPhotos")
        
        let request = requestFactory.makeProductsRequestFactory()
        
        request.getProductPhotos(productId: UUID(uuidString: "0475eb70-725b-11ec-b7a6-0800200c9a66")!) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, successValue)
                XCTAssertNotNil(result.photos)
                XCTAssertNil(result.errorMessage)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
}

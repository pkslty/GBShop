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
    
    let expectations = [XCTestExpectation(description: "GetGoodsById"),
                        XCTestExpectation(description: "GetGoodsList")]
    var errorParser: ErrorParserStub!

    enum ApiErrorStub: Error {
        case fatalError
    }

    struct ErrorParserStub: AbstractErrorParser {
        func parse(_ result: Error) -> Error {
            return ApiErrorStub.fatalError
        }
        
        func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
            return error
        }
    }

    override func setUpWithError() throws {
        
        errorParser = ErrorParserStub()

    }

    override func tearDownWithError() throws {
        
        errorParser = nil
        
    }
    
    func testGetGoodsById() {
        
        let errorParser = ErrorParserStub()
        
        let session: Session = {
            let configuration = URLSessionConfiguration.default
            configuration.httpShouldSetCookies = false
            configuration.headers = .default
            let manager = Session(configuration: configuration)
            return manager
        }()
        let queue = DispatchQueue.global(qos: .utility)
        
        let goods = Goods(errorParser: errorParser, sessionManager: session, queue: queue)
    
        let successValue = GoodByIdResult(result: 1,
                                          productName: "Ноутбук",
                                          price: 45600,
                                          description: "Мощный игровой ноутбук")
        goods.getGoodById(id: 123) { result in
            guard let value = result.value, value == successValue else {
                XCTFail()
                return
            }
            self.expectations[0].fulfill()
        }
        wait(for: [expectations[0]], timeout: 10.0)
    }
    
    func testGetGoodsList() {
        
        let errorParser = ErrorParserStub()
        
        let session: Session = {
            let configuration = URLSessionConfiguration.default
            configuration.httpShouldSetCookies = false
            configuration.headers = .default
            let manager = Session(configuration: configuration)
            return manager
        }()
        let queue = DispatchQueue.global(qos: .utility)
        
        let goods = Goods(errorParser: errorParser, sessionManager: session, queue: queue)
        
        let successValue = [GoodsListItem(productId: 123,
                                          productName: "Ноутбук",
                                          price: 45600),
                            GoodsListItem(productId: 456,
                                          productName: "Мышка",
                                          price: 1000)]
        goods.getGoodsList(page: 1, categoryId: 1) { result in
            guard let value = result.value, value == successValue else {
                XCTFail()
                return
            }
            self.expectations[1].fulfill()
        }
        wait(for: [expectations[1]], timeout: 10.0)
    }


}

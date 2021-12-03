//
//  GBShopTests.swift
//  GBShopTests
//
//  Created by Denis Kuzmin on 26.11.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class GBShopTests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "Download https://failUrl")
    var errorParser: ErrorParserStub!
    
    struct PostStub: Codable {
        let userId: Int
        let id: Int
        let title: String
        let body: String
    }

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
    
    func testShouldDownloadAndParse() {
        let errorParser = ErrorParserStub()
        
        AF.request("https://jsonplaceholder.typicode.com/posts/1").responseCodable(errorParser: errorParser) {(response: DataResponse<PostStub, AFError>) in
            switch response.result {
                case .success(_): break
                case .failure: XCTFail()
            }
            self.expectation.fulfill()

        }
        wait(for: [expectation], timeout: 10.0)
    }


    func testExample() throws {

    }

}

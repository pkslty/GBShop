//
//  ReviewsTests.swift
//  GBShopTests
//
//  Created by Denis Kuzmin on 15.12.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class ReviewsTests: XCTestCase {
    
    var requestFactory: RequestFactory!

    override func setUp() {
        requestFactory = RequestFactory()
    }

    override func tearDown() {
        
        requestFactory = nil
        
    }
    
    func testGetReviews() {
                
        let successValue = 1
        let expectation = expectation(description: "GetReviews")
        
        let request = requestFactory.makeReviewsRequestFactory()
        
        request.getReviews(productId: UUID(uuidString: "0475eb70-725b-11ec-b7a6-0800200c9a66")!) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, successValue)
                XCTAssertNotNil(result.reviews)
                XCTAssertNil(result.errorMessage)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testAddReview() {
                
        let successValue = 1
        let expectation = expectation(description: "AddReview")
        
        let request = requestFactory.makeReviewsRequestFactory()
        
        request.addReview(productId: UUID(), userId: UUID(), text: "Test review", rating: 5) { response in
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
    
    func testRemoveReviewFail() {
        
        let successValue = 0
        let expectation = expectation(description: "RemoveReviewFail")
        
        let request = requestFactory.makeReviewsRequestFactory()
        
        request.removeReview(reviewId: UUID()) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, successValue)
                XCTAssertNil(result.userMessage)
                XCTAssertNotNil(result.errorMessage)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
}

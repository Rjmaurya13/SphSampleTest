//
//  SPHDataWorkerTests.swift
//  SPHSampleTestUITests
//
//  Created by Rajeshkumar on 12/8/20.
//  Copyright © 2020 rajesh. All rights reserved.
//

import XCTest
@testable import SPHSampleTest

class SPhDataWorkerTests: XCTestCase {
    // MARK: Subject under test
    var subject: SPHDataWorker?
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        setupPostDetailsWorker()
    }
    
    override func tearDown() {
        subject = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupPostDetailsWorker() {
        subject = SPHDataWorker()
    }
    
    func testfetchPosts() {
        let expectations = expectation(description: "The Response result match the expected results")
        subject?.fetchMobileData { (response, error) in
            XCTAssertEqual((response?.result?.records)![0]._id, 1)
            expectations.fulfill()
        }
        waitForExpectations(timeout: 20, handler: { (error) in
            if let error = error {
                XCTAssertNil(error, "The api request does not fullfill the expectaion")
            }
        })
    }
}

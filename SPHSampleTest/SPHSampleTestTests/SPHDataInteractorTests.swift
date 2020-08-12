//
//  SPHDataInteractorTests.swift
//  SPHSampleTestUITests
//
//  Created by Rajeshkumar on 12/8/20.
//  Copyright © 2020 rajesh. All rights reserved.
//

import XCTest
@testable import SPHSampleTest

class SPHDataInteractorTests: XCTestCase {
    
    // MARK: Subject under test
    var subject: SPHDataInteractor!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        setupMobileDataInteractor()
    }
    override func tearDown() {
        subject = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupMobileDataInteractor() {
        subject = SPHDataInteractor()
    }
    
    // MARK: Tests
    func testfetchPosts() {
        let presenter = MobileDataPresenterLogicMockData()
        subject.presenter = presenter
        let worker = SPHDataWorker()
        subject.worker = worker
        subject.fetchMobileData(request: SPHDataModel.Data.Request())
        let expectations = expectation(description: "The api request is successful")
        worker.fetchMobileData(completion: {response,error in
            XCTAssertNil(error, "Api request return some error")
            expectations.fulfill()
            //since presenter need some time to present response just after receiving response
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                XCTAssertTrue(presenter.presentPostsCalled, "fetchPosts() should ask the presenter to present the post")
            }
        })
        waitForExpectations(timeout: 30, handler: { (error) in
            if let error = error {
                XCTAssertNil(error, "The api request does not give response")
            }
        })
    }
}
class MobileDataPresenterLogicMockData: SPHDataPresenterLogic{
    var presentPostsCalled = false
    func presentMobileData(response: [SPHDataViewModel]) {
        presentPostsCalled = true
    }
}

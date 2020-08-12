//
//  SPHDataPresenterTests.swift
//  SPHSampleTestUITests
//
//  Created by Rajeshkumar on 12/8/20.
//  Copyright © 2020 rajesh. All rights reserved.
//

import XCTest
@testable import SPHSampleTest

class SPHDataPresenterTests: XCTestCase {
    var subject: SPHDataPresenter!
    var posts: [SPHDataViewModel] = []
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        setupPostDetailsPresenter()
    }
    override func tearDown() {
        subject = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupPostDetailsPresenter() {
        subject = SPHDataPresenter()
    }
    
    // MARK: Tests
    func testPresentPosts() {
        // Given
        let mock = MobileDataDisplayLogicMockData()
        subject.viewController = mock
        let data =  SPHDataViewModel(volume: "23.2333" , quarter: "2016" , id:  0, volumeDataDecrease: true)
        posts.append(data)
        // When
        subject.presentMobileData(response: posts)
        // Then
        XCTAssertTrue(mock.displayPostCalled, "PresentPosts() should ask the view controller to display the result")
    }
}
// MARK: Test doubles
class MobileDataDisplayLogicMockData: SPHDataProtocol {
    var displayPostCalled = false
    func displayMobileData(viewModel: [SPHDataViewModel]) {
        displayPostCalled = true
    }
}

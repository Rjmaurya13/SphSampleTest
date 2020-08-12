//
//  SPHDataViewControllerTests.swift
//  SPHSampleTestUITests
//
//  Created by Rajeshkumar on 12/8/20.
//  Copyright © 2020 rajesh. All rights reserved.
//

import XCTest
@testable import SPHSampleTest

class SPHDataViewControllerTests: XCTestCase {
    var viewControl: SPHDataViewController!
    var window: UIWindow!
    var posts: [SPHDataViewModel] = []
    // var cell: MobileDataTableViewCell?
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupMobileDataViewController()
        // cell = MobileDataTableViewCell()
    }
    
    override func tearDown() {
        window = nil
        viewControl = nil
        posts = []
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupMobileDataViewController() {
        viewControl = SPHDataViewController()
    }
    
    func loadView() {
        window.addSubview(viewControl.view)
        RunLoop.current.run(until: Date())
    }
    
    func testfetchMobileData() {
        // Given
        let logicMockData = MobileDataBusinessLogicMockData()
        viewControl.interactor = logicMockData
        viewControl.fetchMobileData()
        // When
        loadView()
        // Then
        XCTAssertTrue(logicMockData.fetchPostCalled, "viewDidLoad() should ask the interactor to do fetch posts")
    }
    
    func testDisplayMobileData() {
        //Given
        let data =  SPHDataViewModel(volume: "23.2333" , quarter: "2016" , id:  0, volumeDataDecrease: true)
        posts.append(data)
        //when
        loadView()
        viewControl.displayMobileData(viewModel: posts )
        // Then
        XCTAssertEqual(posts.count, 1)
    }
    // MARK: Referesh Data
    func testShowPupUp() {
        let delegate = MockshowPopUpDelegateData()
        let cell = viewControl.tableView(viewControl.tableView, cellForRowAt: IndexPath(item: 0, section: 0)) as? SPHDataTableViewCell
        cell?.delegate = delegate
        cell?.increaseDecreaseVolume.sendActions(for: .touchUpInside)
        viewControl.showPopUpWithMessage()
        XCTAssertTrue(delegate.isShow == true, "popUp is Shown")
    }
}
// MARK: Test doubles
class MobileDataBusinessLogicMockData: MobileDataDetailsBusinessLogic {
    var fetchPostCalled = false
    func fetchMobileData(request: SPHDataModel.Data.Request) {
        fetchPostCalled = true
    }
}
class MockshowPopUpDelegateData: SPHDataTableViewCellDelegate {
    var isShow = false
    func showPopUpWithMessage() {
        isShow = true
    }
}

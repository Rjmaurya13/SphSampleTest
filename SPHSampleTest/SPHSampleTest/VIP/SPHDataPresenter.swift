//
//  SPHDataPresenter.swift
//  SPHSampleTest
//
//  Created by Rajeshkumar on 12/8/20.
//  Copyright © 2020 rajesh. All rights reserved.
//

import Foundation
import UIKit

protocol SPHDataPresenterLogic: class {
    func presentMobileData(response: [SPHDataViewModel])
}

class MobileDataPresenter: SPHDataPresenterLogic {
    weak var viewController: SPHDataProtocol?

    func presentMobileData(response: [SPHDataViewModel]) {
        viewController?.displayMobileData(viewModel: response)
    }
}

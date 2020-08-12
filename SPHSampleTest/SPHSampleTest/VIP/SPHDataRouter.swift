//
//  SPHDataRouter.swift
//  SPHSampleTest
//
//  Created by Rajeshkumar on 12/8/20.
//  Copyright © 2020 rajesh. All rights reserved.
//

import Foundation
import UIKit

@objc protocol SPHDetailsRoutingLogic {
    func routeToSomewhere()
}

protocol SPHDetailsDataPassing {
    var dataStore: MobileDetailsDataStore? { get }
}

class SPHDataRouter: NSObject, SPHDetailsDataPassing {
    weak var viewController: SPHDataViewController?
    var dataStore: MobileDetailsDataStore?
}

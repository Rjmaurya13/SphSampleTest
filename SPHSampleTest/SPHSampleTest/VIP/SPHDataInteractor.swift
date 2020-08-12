//
//  SPHDataInteractor.swift
//  SPHSampleTest
//
//  Created by Rajeshkumar on 12/8/20.
//  Copyright © 2020 rajesh. All rights reserved.
//

import Foundation
protocol MobileDataDetailsBusinessLogic {
    func fetchMobileData(request: SPHDataModel.Data.Request)
}

protocol MobileDetailsDataStore {
    var posts: [SPHDataViewModel] { get set }
}

class MobileDataInteractor: MobileDataDetailsBusinessLogic, MobileDetailsDataStore {
    var posts: [SPHDataViewModel] = []
    var presenter: SPHDataPresenterLogic?
    var worker: SPHDataWorker? = SPHDataWorker()
    
    // MARK: Do something
    
    func fetchMobileData(request: SPHDataModel.Data.Request) {
        worker?.fetchMobileData(completion: { (response , error) in
            if response != nil{
                self.addDataYearly(record: (response?.result?.records)!)
            }else{
                print("error")
            }
        })
    }
    
    func addDataYearly(record :  [SPHDataModel.Data.Records]) {
        var lastYear = 0
        var year = 0
        self.posts = []
        var lastQData = 0.00
        var isValueDataDesc = false
        var yearlyMobileData = 0.00
        for value in (record) {
            let quarterData = value.quarter?.components(separatedBy: "-")
            year  = Int(quarterData?[0] ?? "") ?? 0
            if year >= 2008 && year <= 2019 {
                let mobileData = Double(Float(value.volume_of_mobile_data ?? "") ?? 0)
                if lastYear == year || lastYear == 0 {
                    yearlyMobileData += mobileData
                    isValueDataDesc = decInDataYearly(lastQData:lastQData, currentQData:mobileData, isValueDataDesc:isValueDataDesc)
                }else if lastYear != 0 {
                    let model = SPHDataViewModel(volume: String(yearlyMobileData) , quarter: String(lastYear) , id: value._id ?? 0, volumeDataDecrease: isValueDataDesc)
                    posts.append(model)
                    yearlyMobileData = mobileData
                    isValueDataDesc = false
                }
                lastQData = mobileData
                lastYear = year
            }
        }
        self.presenter?.presentMobileData(response: posts)
    }
    
    func decInDataYearly(lastQData: Double, currentQData: Double, isValueDataDesc: Bool) -> Bool {
        if !isValueDataDesc && currentQData > lastQData {
            return false
        }
        return true
    }
}

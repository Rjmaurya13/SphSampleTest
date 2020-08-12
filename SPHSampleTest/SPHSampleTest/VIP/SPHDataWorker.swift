//
//  SPHDataWorker.swift
//  SPHSampleTest
//
//  Created by Rajeshkumar on 12/8/20.
//  Copyright © 2020 rajesh. All rights reserved.
//

import UIKit

class SPHDataWorker {
    func fetchMobileData(completion: @escaping (SPHDataModel.Data.Response?, Error?) -> ()) {
    guard let publicUrl = URL(string: UrlConstant.BaseURL + UrlConstant.UrlCollection.UserDetailUrl.UserPosts) else { return }
    URLSession.shared.dataTask(with: publicUrl) { (data, response
        , error) in
        guard let data = data else { return }
        do {
            let decoder = JSONDecoder()
            let publicData = try decoder.decode(SPHDataModel.Data.Response.self, from: data)
            completion(publicData,nil)
        } catch let err {
            completion(nil,err)
        }
        }.resume()
  }
}

//
//  SPHDataViewController.swift
//  SPHSampleTest
//
//  Created by Rajeshkumar on 12/8/20.
//  Copyright © 2020 rajesh. All rights reserved.
//

import Foundation
import UIKit

class SPHDataViewController: UITableViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SPHDataViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SPHDataTableViewCell.reuseIdentifier, for: indexPath) as? SPHDataTableViewCell  else {
            return UITableViewCell()
        }
        cell.delegate = self
        
        return cell
    }
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension SPHDataViewController: SPHDataTableViewCellDelegate {
    func showPopUpWithMessage() {
        let alert = UIAlertController(title: "Alert", message: "Decrease in volume data.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.view.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

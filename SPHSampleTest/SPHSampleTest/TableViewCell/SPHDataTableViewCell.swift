//
//  SPHDataTableViewCell.swift
//  SPHSampleTest
//
//  Created by Rajeshkumar on 12/8/20.
//  Copyright © 2020 rajesh. All rights reserved.
//

import UIKit
protocol SPHDataTableViewCellDelegate: class {
    func showPopUpWithMessage()
}
class SPHDataTableViewCell: SPHTableViewCell {
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblYearDescription: UILabel!
    @IBOutlet weak var lblVolume: UILabel!
    @IBOutlet weak var lblVolumeDescription: UILabel!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var increaseDecreaseVolume: UIButton! {
        didSet {
            increaseDecreaseVolume.isHidden = true
        }
    }
    weak var delegate: SPHDataTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        viewBg.backgroundColor = .lightText
        viewBg.layer.cornerRadius = 8
        // Initialization code
    }
   
    @IBAction func clickOnButtonEvent(_ sender: Any) {
        delegate?.showPopUpWithMessage()
    }
}


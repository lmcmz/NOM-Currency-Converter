//
//  SettingAppTableViewCell.swift
//  ExchangeRate
//
//  Created by lmcmz on 23/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import UIKit
import FoldingCell

class SettingAppTableViewCell: FoldingCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backViewColor = self.foregroundView.backgroundColor!
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.33, 0.26, 0.26, 0.33, 0.26] // timing animation for each view
        return durations[itemIndex]
    }
    
    @IBAction func pureButtonClick() {
        UIApplication.shared.open(URL(string: "itms-apps://itunes.apple.com/us/app/apple-store/id375380948?mt=8")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func globalButtonClick() {
        UIApplication.shared.open(URL(string: "itms-apps://itunes.apple.com/us/app/apple-store/id375380948?mt=8")!, options: [:], completionHandler: nil)
    }
    
    
}

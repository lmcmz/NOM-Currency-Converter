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
    
    @IBOutlet var label:UILabel!
    @IBOutlet var subLabel:UILabel!
    @IBOutlet var descLabel_1:UILabel!
    @IBOutlet var descLabel_2:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backViewColor = self.foregroundView.backgroundColor!
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(language:Language) {
        switch language {
        case .Chinese:
            label.text = "我的其他应用"
            descLabel_1.text = "每日三句格言，以奇特方式呈现"
            descLabel_2.text = "支持超过200+国家的基础物价查询"
        case .English:
            label.text = "My Apps"
            descLabel_1.text = "Show 3 quotes per day with awesome animation"
            descLabel_2.text = "Check average prices and info in other countries"
        case .Spanish:
            label.text = "Mi Apps"
            descLabel_1.text = "Show 3 quotes per day with awesome animation"
            descLabel_2.text = "Check average prices and info in other countries"
        }
        
        subLabel.text = label.text
    }

    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.33, 0.26, 0.26, 0.33, 0.26] // timing animation for each view
        return durations[itemIndex]
    }
    
    @available(iOS 10.0, *)
    @IBAction func pureButtonClick() {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: "itms-apps://itunes.apple.com/cn/app/pure-quotes/id988629611?mt=8")!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL(string:"itms-apps://itunes.apple.com/cn/app/pure-quotes/id988629611?mt=8")!)
        }
    }
    
    @IBAction func globalButtonClick() {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: "itms-apps://itunes.apple.com/us/app/id982807671")!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL(string:"itms-apps://itunes.apple.com/us/app/id982807671")!)
        }
    }
    
    
}

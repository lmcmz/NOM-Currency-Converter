//
//  SettingLanguageTableViewCell.swift
//  ExchangeRate
//
//  Created by lmcmz on 23/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import UIKit
import FoldingCell

class SettingLanguageTableViewCell: FoldingCell {

    @IBOutlet var buttonView:UIView!
    
    @IBOutlet var englishButton:UIControl!
    @IBOutlet var chineseButton:UIControl!
    @IBOutlet var spanishButton:UIControl!
    
    @IBOutlet var gardientButton:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backViewColor = self.foregroundView.backgroundColor!
        englishButton.layer.cornerRadius = 45.6
        chineseButton.layer.cornerRadius = 45.6
        spanishButton.layer.cornerRadius = 45.6
        gardientButton.layer.cornerRadius = 45.6
        gardientButton.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.33, 0.26, 0.26] // timing animation for each view
        return durations[itemIndex]
    }
    
    @IBAction func buttonClick(button:UIControl) {
        let tag = button.tag
        var frame = CGRect()
        switch tag {
        case 1:
            frame = chineseButton.convert(chineseButton.bounds, to: self.buttonView)
        case 2:
            frame = englishButton.convert(englishButton.bounds, to: self.buttonView)
        case 3:
            frame = spanishButton.convert(spanishButton.bounds, to: self.buttonView)
        default:
            frame = englishButton.convert(englishButton.bounds, to: self.buttonView)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: [.curveEaseInOut], animations: {
            self.gardientButton.frame = frame
        }, completion: nil)
    }
}

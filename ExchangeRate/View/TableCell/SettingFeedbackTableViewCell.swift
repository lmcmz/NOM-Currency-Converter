//
//  SettingFeedbackTableViewCell.swift
//  ExchangeRate
//
//  Created by lmcmz on 23/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import UIKit

class SettingFeedbackTableViewCell: UITableViewCell {

    @IBOutlet var label:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(language:Language) {
        switch language {
        case .Chinese:
            label.text = "给我提建议"
        case .English:
            label.text = "Feedback"
        case .Spanish:
            label.text = "Sugerencia"
        }
    }
    
}

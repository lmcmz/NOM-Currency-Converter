//
//  SettingVersionTableViewCell.swift
//  ExchangeRate
//
//  Created by lmcmz on 23/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import UIKit

class SettingVersionTableViewCell: UITableViewCell {

    @IBOutlet var monsterImage:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let numberRoll = Int(arc4random_uniform(5))
        if numberRoll > 2 {
            monsterImage.image = UIImage(named: "monster")
        } else {
            monsterImage.image = UIImage(named: "monster-sleep")
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

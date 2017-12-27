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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(isSleeping:Bool) {
        
        if !isSleeping {
            monsterImage.image = UIImage(named: "monster")
        } else {
            monsterImage.image = UIImage(named: "monster-sleep")
        }
    }
    
}

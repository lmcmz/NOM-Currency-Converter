//
//  SettingNotificationTableViewCell.swift
//  ExchangeRate
//
//  Created by lmcmz on 23/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import UIKit
import SJFluidSegmentedControl

class SettingNotificationTableViewCell: UITableViewCell, SJFluidSegmentedControlDelegate, SJFluidSegmentedControlDataSource {

     @IBOutlet weak var notiControl: SJFluidSegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                            gradientColorsForBounce bounce: SJFluidSegmentedControlBounce) -> [UIColor] {
        switch bounce {
        case .left:
            return [UIColor(red: 51 / 255.0, green: 149 / 255.0, blue: 182 / 255.0, alpha: 1.0)]
        case .right:
            return [UIColor(red: 9 / 255.0, green: 82 / 255.0, blue: 107 / 255.0, alpha: 1.0)]
        }
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                          gradientColorsForSelectedSegmentAtIndex index: Int) -> [UIColor] {
        switch index {
        case 0:
            return [UIColor(hexString: "8AD5E2"),
                    UIColor(hexString: "BDD9B2")]
        case 1:
            return [UIColor(hexString: "BDD9B2"),
                    UIColor(hexString: "FFDD77")]
        default:
            break
        }
        return [.clear]
    }
    
    func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int {
        return 2
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                          titleForSegmentAtIndex index: Int) -> String? {
        if index == 0 {
            return "OFF"
        }
        return "ON"
    }
}

//
//  SettingChartTableViewCell.swift
//  ExchangeRate
//
//  Created by lmcmz on 22/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import UIKit
import FoldingCell
import SJFluidSegmentedControl

class SettingChartTableViewCell: FoldingCell, SJFluidSegmentedControlDelegate, SJFluidSegmentedControlDataSource {

    @IBOutlet weak var periodControl: SJFluidSegmentedControl!
    @IBOutlet weak var frequencyControl: SJFluidSegmentedControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        periodControl.delegate = self
        periodControl.dataSource = self
        
        frequencyControl.delegate = self
        frequencyControl.delegate = self
        self.backViewColor = self.foregroundView.backgroundColor!
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.33, 0.26, 0.26] // timing animation for each view
        return durations[itemIndex]
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                          gradientColorsForSelectedSegmentAtIndex index: Int) -> [UIColor] {
        
        let array1 = [[UIColor(hexString: "4CB9C6"),UIColor(hexString: "8AD5E2")],
                     [UIColor(hexString: "8AD5E2"),UIColor(hexString: "ACD8C2")],
                     [UIColor(hexString: "ACD8C2"),UIColor(hexString: "BDD9B2")],
                     [UIColor(hexString: "BDD9B2"),UIColor(hexString: "DEDB95")],
                     [UIColor(hexString: "DEDB95"),UIColor(hexString: "FFDD77")]]
        
//        let array2 = [[UIColor(hexString: "FFDD77"),UIColor(hexString: "DEDB95")],
//                     [UIColor(hexString: "DEDB95"),UIColor(hexString: "BDD9B2")],
//                     [UIColor(hexString: "BDD9B2"),UIColor(hexString: "ACD8C2")],
//                     [UIColor(hexString: "ACD8C2"),UIColor(hexString: "8AD5E2")],
//                     [UIColor(hexString: "8AD5E2"),UIColor(hexString: "4CB9C6")]]
//        if segmentedControl == frequencyControl {
//            return array2[index]
//        }
        return array1[index]
    }
    
    func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int {
        if segmentedControl == self.periodControl {
            return  YahooPeriod.supportNumber()
        }
        return YahooFrenquency.supportNumber()
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                          titleForSegmentAtIndex index: Int) -> String? {
        if segmentedControl == self.periodControl {
            let array = [YahooPeriod.fiveD, YahooPeriod.oneMO, YahooPeriod.threeMO, YahooPeriod.oneY, YahooPeriod.fiveY]
            return YahooPeriod.getString(period: array[index])
        }
        
        let array = [YahooFrenquency.halfHour, YahooFrenquency.oneHour, YahooFrenquency.oneDay, YahooFrenquency.oneWeek, YahooFrenquency.threeMonth]
        return YahooFrenquency.getString(frenquency: array[index])
    }
    
}

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
    
    @IBOutlet var errorLabel: UILabel!
    
    static let changePeriodNotification = "changePeriodNotification"
    static let changeFrenqencyNotification = "changeFrenqencyNotification"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        periodControl.delegate = self
        periodControl.dataSource = self
        
        frequencyControl.delegate = self
        frequencyControl.delegate = self
        self.backViewColor = self.foregroundView.backgroundColor!
        
        periodControl.currentSegment = CacheManager.getPeriodCache().rawValue
        frequencyControl.currentSegment = CacheManager.getFrequencyCache().rawValue
        
        errorLabel.alpha = 0
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
        return YahooFrequency.supportNumber()
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                          titleForSegmentAtIndex index: Int) -> String? {
        if segmentedControl == self.periodControl {
            let array = [YahooPeriod.fiveD, YahooPeriod.oneMO, YahooPeriod.threeMO, YahooPeriod.oneY, YahooPeriod.fiveY]
            return YahooPeriod.getString(period: array[index])
        }
        
        let array = [YahooFrequency.oneHour, YahooFrequency.oneDay, YahooFrequency.oneWeek,YahooFrequency.oneMonth, YahooFrequency.threeMonth]
        return YahooFrequency.getString(frenquency: array[index])
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, didChangeFromSegmentAtIndex fromIndex: Int, toSegmentAtIndex toIndex: Int) {
        
        if !checkVaild() {
            segmentedControl.setCurrentSegmentIndex(fromIndex, animated: true)
            return
        }
        
        if segmentedControl == self.periodControl {
            let Yahoo = YahooPeriod(rawValue: toIndex)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: SettingChartTableViewCell.changePeriodNotification), object: Yahoo)
            return
        }

        let Yahoo = YahooFrequency(rawValue: toIndex)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: SettingChartTableViewCell.changeFrenqencyNotification), object: Yahoo)
    }
    
    func checkVaild() -> Bool {
        let period = periodControl.currentSegment
        let frenquency = frequencyControl.currentSegment
        if period == YahooPeriod.fiveY.rawValue {
            if frenquency == 0 || frenquency == 1 {
                errorAnimation()
                return false
            }
        }
        
        if period == YahooPeriod.oneY.rawValue {
            if frenquency == 0 {
                errorAnimation()
                return false
            }
        }
        return true
    }
    
    func errorAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat,.autoreverse], animations: {
            self.errorLabel.alpha = 1.0
        }) { (finish) in
        }
        
        UIView.animate(withDuration: 0.5, delay: 1.5, options: [], animations: {
            self.errorLabel.alpha = 0
        }, completion: nil)
    }
    
}

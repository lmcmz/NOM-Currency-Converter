//
//  SettingLanguageTableViewCell.swift
//  ExchangeRate
//
//  Created by lmcmz on 23/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import UIKit
import FoldingCell
import SnapKit

class SettingLanguageTableViewCell: FoldingCell, CAAnimationDelegate {

    static let languageNotification = "languageNotification"
    
    @IBOutlet var label:UILabel!
    @IBOutlet var subLabel:UILabel!
    
    @IBOutlet var buttonView:UIView!
    @IBOutlet var englishButton:UIControl!
    @IBOutlet var chineseButton:UIControl!
    @IBOutlet var spanishButton:UIControl!
    
    @IBOutlet var gardientButton_1:UIImageView!
    @IBOutlet var gardientButton_2:UIImageView!
    @IBOutlet var gardientButton_3:UIImageView!
    
    fileprivate var previousStyleViewSnapshot: UIView?
    
    var refrenceVC:SettingViewController!
    let maskLayer = CAShapeLayer()
    let view = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backViewColor = self.foregroundView.backgroundColor!
        let language = CacheManager.getLanguage()
        self.gardientButton_1.isHidden = true
        self.gardientButton_2.isHidden = true
        self.gardientButton_3.isHidden = true
        switch language {
        case .Chinese:
            self.gardientButton_1.isHidden = false
        case .English:
            self.gardientButton_2.isHidden = false
        case .Spanish:
            self.gardientButton_3.isHidden = false
        }
        
        var cornerRadius:CGFloat = 44
        if Constants.SCREEN_WIDTH == 320 {
            cornerRadius = 35
        }
        
        englishButton.layer.cornerRadius = cornerRadius
        chineseButton.layer.cornerRadius = cornerRadius
        spanishButton.layer.cornerRadius = cornerRadius
        gardientButton_1.layer.cornerRadius = cornerRadius
        gardientButton_1.layer.masksToBounds = true
        gardientButton_2.layer.cornerRadius = cornerRadius
        gardientButton_2.layer.masksToBounds = true
        gardientButton_3.layer.cornerRadius = cornerRadius
        gardientButton_3.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(language:Language) {
        self.gardientButton_1.isHidden = true
        self.gardientButton_2.isHidden = true
        self.gardientButton_3.isHidden = true
        switch language {
        case .Chinese:
            self.gardientButton_1.isHidden = false
            label.text = "语言"
        case .English:
            self.gardientButton_2.isHidden = false
            label.text = "Language"
        case .Spanish:
            self.gardientButton_3.isHidden = false
            label.text = "Idiomas"
        }
        subLabel.text = label.text
    }
    
    
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.33, 0.26, 0.26] // timing animation for each view
        return durations[itemIndex]
    }
    
    @IBAction func buttonClick(button:UIControl) {
        let tag = button.tag
//        var frame = CGRect()
//        switch tag {
//        case 1:
//            frame = chineseButton.convert(chineseButton.bounds, to: self.buttonView)
//        case 2:
//            frame = englishButton.convert(englishButton.bounds, to: self.buttonView)
//        case 3:
//            frame = spanishButton.convert(spanishButton.bounds, to: self.buttonView)
//        default:
//            frame = englishButton.convert(englishButton.bounds, to: self.buttonView)
//        }
//        
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: [.curveEaseInOut], animations: {
//            self.gardientButton.frame = frame
//        }, completion: nil)
        
        let noti = Notification(name: Notification.Name(rawValue: SettingLanguageTableViewCell.languageNotification), object: tag, userInfo: nil)
        NotificationCenter.default.post(noti)
        
        let testFrame = button.convert(button.bounds, to: refrenceVC.parent?.view)
        let originPath = UIBezierPath(ovalIn: testFrame)
//        let extremePoint = CGPoint(x: button.center.x, y: button.center.y)
//        let radius = sqrt(extremePoint.x * extremePoint.x + extremePoint.y * extremePoint.y)
        
        let finalPath = UIBezierPath(ovalIn: button.frame.insetBy(dx: -Constants.SCREEN_HEIGHT, dy: -Constants.SCREEN_HEIGHT))
        
//        let window = refrenceVC.tableView.window
//        previousStyleViewSnapshot = window?.snapshotView(afterScreenUpdates: false)
//        window?.addSubview(previousStyleViewSnapshot!)
//        window?.bringSubview(toFront: previousStyleViewSnapshot!)
//
//        let snapshotMaskLayer = CAShapeLayer()
//        snapshotMaskLayer.path = UIBezierPath(rect: (window?.bounds)!).cgPath
//        snapshotMaskLayer.fillColor = UIColor.black.cgColor
//        previousStyleViewSnapshot?.layer.mask = snapshotMaskLayer
        
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        maskLayer.path = finalPath.cgPath
        
        refrenceVC.parent?.view.layer.mask = maskLayer
//        let image = refrenceVC.parent?.view.snpshot()
//        refrenceVC.parent?.view.addSubview(view)
//        view.layer.mask = maskLayer
//        maskLayer.contents = image?.cgImage
//        maskLayer.opacity = 0.2
//        maskLayer.
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = originPath.cgPath
        animation.toValue = finalPath.cgPath
        animation.duration = 1.0
        animation.delegate = self
        maskLayer.add(animation, forKey: "path")
        
        CATransaction.commit()
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            self.previousStyleViewSnapshot?.removeFromSuperview()
        }
    }
}

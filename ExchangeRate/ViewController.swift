//
//  ViewController.swift
//  ExchangeRate
//
//  Created by lmcmz on 03/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: BaseViewController, UIScrollViewDelegate,UIGestureRecognizerDelegate {
    
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var contentHeight: NSLayoutConstraint!
    @IBOutlet var contentWidth: NSLayoutConstraint!
    
    @IBOutlet var settingImage: UIImageView!
    @IBOutlet var calculatorImage: UIImageView!
    @IBOutlet var rateImage: UIImageView!
    
    func initView() {
        let width = UIScreen.main.bounds.width
        
        contentView.snp.makeConstraints { (make) in
            make.width.equalTo(Constants.SCREEN_WIDTH*3)
            make.height.equalTo(scrollView.snp.height)
        }
        
        let calculatorVC = CalculatorViewController()
        self.addChildViewController(calculatorVC)
        contentView.addSubview(calculatorVC.view)
        calculatorVC.view.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.width.equalTo(width)
            make.height.equalTo(contentView.snp.height)
        }
        
        let rateVC = RateViewController()
        self.addChildViewController(rateVC)
        contentView.addSubview(rateVC.view)
        rateVC.view.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(width)
            make.width.equalTo(width)
            make.height.equalTo(contentView.snp.height)
        }
        
        rateVC.calculatorRef = calculatorVC
        calculatorVC.rateRef = rateVC
        
        let settingVC = SettingViewController()
        self.contentView.addSubview(settingVC.view)
        self.addChildViewController(settingVC)
        settingVC.view.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(width*2)
            make.width.equalTo(width)
            make.height.equalTo(contentView.snp.height)
        }
        
        DispatchQueue.main.async {
            self.scrollView.setContentOffset(CGPoint(x: Constants.SCREEN_WIDTH, y: 0), animated: false)
        }
        
//        scrollView.isScrollEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    // MARK: ScrollView Delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let distance = scrollView.contentOffset.x
        let page = floor(distance/Constants.SCREEN_WIDTH)
        
        settingImage.isHighlighted = false
        calculatorImage.isHighlighted = false
        rateImage.isHighlighted = false
        
        switch page {
        case 0:
            self.calculatorImage.isHighlighted = true
        case 1:
            self.rateImage.isHighlighted = true
        case 2:
            self.settingImage.isHighlighted = true
        default:
            self.calculatorImage.isHighlighted = true
        }
    }
    
     // MARK: Action
    
    @IBAction func buttonClicked(view: UIControl) {
        let position = Constants.SCREEN_WIDTH * CGFloat(view.tag - 1)
        self.scrollView.setContentOffset(CGPoint(x: position , y: 0), animated: true)
    }
}


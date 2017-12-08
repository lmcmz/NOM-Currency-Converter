//
//  ViewController.swift
//  ExchangeRate
//
//  Created by lmcmz on 03/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

  
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var contentView: UIView!
  @IBOutlet var contentHeight: NSLayoutConstraint!
  @IBOutlet var contentWidth: NSLayoutConstraint!
  
  @IBOutlet var calendarImage: UIImageView!
  @IBOutlet var calculatorImage: UIImageView!
  @IBOutlet var rateImage: UIImageView!
  
  func initView() {
    contentWidth.constant = Constants.SCREEN_WIDTH * 3
    contentHeight.constant = Constants.HomePageVCHeight
    
    let rateVC = RateViewController()
    rateVC.view.frame = CGRect(x: Constants.SCREEN_WIDTH, y: 0, width: Constants.SCREEN_WIDTH, height: Constants.HomePageVCHeight - 112)
    self.addChildViewController(rateVC)
    contentView.addSubview(rateVC.view)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initView()
  }
  

  // MARK: ScrollView Delegate
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let distance = scrollView.contentOffset.x
    let page = floor(distance/Constants.SCREEN_WIDTH)
    
    calendarImage.isHighlighted = false
    calculatorImage.isHighlighted = false
    rateImage.isHighlighted = false
    
    switch page {
    case 0:
      self.calculatorImage.isHighlighted = true
    case 1:
      self.rateImage.isHighlighted = true
    case 2:
      self.calendarImage.isHighlighted = true
    default:
      self.calculatorImage.isHighlighted = true
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }


}


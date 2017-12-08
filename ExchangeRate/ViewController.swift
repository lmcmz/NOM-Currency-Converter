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
  @IBOutlet var calculator: UIImageView!
  @IBOutlet var rateImage: UIImageView!
  
  func setUpView() {
    let view1 = UIView()
    view1.frame = CGRect(x: 0, y: 0, width: Constants.SCREEN_WIDTH, height: Constants.SCREEN_HEIGHT)
    view1.backgroundColor = UIColor.blue
    let view2 = UIView()
    view2.frame = CGRect(x: Constants.SCREEN_WIDTH, y: 0, width: Constants.SCREEN_WIDTH, height: Constants.SCREEN_HEIGHT)
    view2.backgroundColor = UIColor.red
    
    contentWidth.constant = Constants.SCREEN_WIDTH * 3
    contentHeight.constant = Constants.SCREEN_HEIGHT
    contentView.addSubview(view1)
    contentView.addSubview(view2)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
  }
  

  // MARK: ScrollView Delegate
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    var distance = scrollView.contentOffset.x
    var page = floor(distance/Constants.SCREEN_WIDTH)
    switch page {
    case 1:
      self.calculator.isHighlighted
    default:
      <#code#>
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }


}


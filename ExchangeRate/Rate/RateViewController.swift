//
//  RateViewController.swift
//  ExchangeRate
//
//  Created by lmcmz on 08/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import BEMSimpleLineGraph
import VBFPopFlatButton
import MSNumberScrollAnimatedView

class RateViewController: BaseViewController, BEMSimpleLineGraphDelegate, BEMSimpleLineGraphDataSource {
    
    @IBOutlet var chartView: BEMSimpleLineGraphView!
    @IBOutlet var exchangeButton: UIControl!
    @IBOutlet var country1: UIControl!
    @IBOutlet var country2: UIControl!
    
    @IBOutlet var country1_image: UIImageView!
    @IBOutlet var country2_image: UIImageView!
    
    @IBOutlet var country1_label: UILabel!
    @IBOutlet var country2_label: UILabel!
    
//    @IBOutlet var daily_rate_label: UILabel!
    @IBOutlet var date_label: UILabel!
    @IBOutlet var up_down_image: UIImageView!
    @IBOutlet var daily_rate_label: MSNumberScrollAnimatedView!
    
    @IBOutlet var animationButton: VBFPopFlatButton!
    
    var baseCountry: Currency!
    var gradient  : CGGradient?
    var lineGradient  : CGGradient?
    var repo: FixerModel!
    var chartsData: YahooChartModel!
    
    var gotFixerData: Bool = false
    var gotYahooData: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initView()
    }
    
    func initView() {
        chartView.delegate = self
        chartView.dataSource = self
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let topColor = UIColor(hexString: "333B5E")
        let bottomColor = UIColor(hexString: "85D7E2", alpha: 1.0)
        let gradientColors : [CGColor] = [topColor.cgColor,bottomColor.cgColor]
        let locations : [CGFloat] = [1.0, 0.0]
        
        let topColor1 = UIColor(hexString: "85D7E2", alpha: 0.1)
        let bottomColor1 = UIColor(hexString: "85D7E2", alpha: 1.0)
        let gradientColors1 : [CGColor] = [topColor1.cgColor,bottomColor1.cgColor]
        let locations1 : [CGFloat] = [0.0, 1.0]
        
        self.gradient = CGGradient(colorsSpace: colorSpace, colors: gradientColors as CFArray, locations: locations)
        self.lineGradient = CGGradient(colorsSpace: colorSpace, colors: gradientColors1 as CFArray, locations: locations1)
        
        chartView.gradientBottom = self.gradient!
//        chartView.gradientLine = self.lineGradient!
        
        
        chartView.enableTouchReport = true
        chartView.enablePopUpReport = true
        chartView.formatStringForValues = "%.3f";
        
        chartView.enableXAxisLabel = false
        chartView.enableBottomReferenceAxisFrameLine = false
        
        animationButton.currentButtonType = .buttonPausedType
        animationButton.currentButtonStyle = .buttonRoundedStyle
        animationButton.lineThickness = 5
        animationButton.tintColor = UIColor(hexString: "85D7E2")
        animationButton.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        
        daily_rate_label.textColor = UIColor.white
        daily_rate_label.font = UIFont(name: "HelveticaNeue-Bold", size: 70)
        daily_rate_label.density = 3
        daily_rate_label.minLength = 4
        
        daily_rate_label.duration  = 0.8
        daily_rate_label.durationOffset = 0.2
        daily_rate_label.isAscending = true
        daily_rate_label.number = NSNumber(value: 00.00)
//        daily_rate_label.startAnimation()
    }
    
    func initData() {
        requestData()
    }
    
    func reloadData() {
        let model = self.repo
        
        let date_rate = model?.date?.readDateFromString(formatter: "yyy-mm-dd")
        self.date_label.text = date_rate?.printDateFromDate(formatter: "MMM.dd.yyyy")
        let country2_currency = Currency(rawValue: country2_label.text!)
        let value = String(format:"%.2f",(model?.getValue(currency: country2_currency!))!)
        self.daily_rate_label.number = NSNumber(value: Double(value)!)
        self.daily_rate_label.startAnimation()
//        self.daily_rate_label.text =
        baseCountry = Currency(rawValue: (model?.base)!)
    }
    
    func switchData() {
        swap(&country1_image.image, &country2_image.image)
        swap(&country1_label.text, &country2_label.text)
        let country1_currency = Currency(rawValue: country1_label.text!)
        let country2_currency = Currency(rawValue: country2_label.text!)
        if baseCountry.rawValue == country1_label.text {
//            self.daily_rate_label.text = String(format:"%.2f",(self.repo.getValue(currency: country2_currency!))!)
            return
        }
//        self.daily_rate_label.text = String(format:"%.2f",1/(self.repo.getValue(currency: country1_currency!))!)
    }
    
    func checkTrend(data:YahooChartModel) {
        let todayData = data.close!.last!.doubleValue
        let yesterdayData = data.close![(data.close?.count)! - 2].doubleValue
        if todayData > yesterdayData {
            self.animationButton.animate(to: .buttonFastForwardType)
        } else {
            self.animationButton.animate(to: .buttonRewindType)
        }
    }
    
    // MARK: Action
    
    @IBAction func exchangeButtonClicked() {
        let original = self.exchangeButton.transform
        UIView.animate(withDuration: 0.3, animations: {
            self.exchangeButton.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }) { (true) in
            self.exchangeButton.transform = original
        }
        
        swithAnimation()
    }
    
    @IBAction func countryButtonClick() {
        CountryViewController.showInController(controller: self.parent!)
    }
    
    
    // MARK: Animation
    
    func swithAnimation() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromBottom
        country1.layer.add(transition, forKey: "country1_animation")
        transition.subtype = kCATransitionFromTop
        country2.layer.add(transition, forKey: "country2_animation")
        switchData()
    }
    
    // MARK: Request
    
    func requestData() {
        
        LodingHelper.sharedHelper.show()
        
        weak var weakSelf = self
        yahooProvider.request(Yahoo.chart("AUDCNY", "1mo")) { (result) in
            if case let .success(response) = result {
                self.gotYahooData = true
                self.shouldRemoveLoading()
                let model = response.mapObject(YahooChartResponseModel.self)
                let data = model?.makeModel()
                weakSelf?.chartsData = data
                weakSelf?.chartView.reloadGraph()
                weakSelf?.checkTrend(data: data!)
//                weakSelf?.setDataCount(data: data!)
            }
        }
        
        fixerProvider.request(fixer.latest(self.country1_label.text!)) { result in
                if case let .success(response) = result {
                    self.gotFixerData = true
                    self.shouldRemoveLoading()
                    let model = response.mapObject(FixerModel.self) as FixerModel!
                    self.repo = model
                    self.reloadData()
                }
        }
    }
    
    
    func shouldRemoveLoading() {
        if self.gotFixerData && self.gotYahooData {
            LodingHelper.sharedHelper.remove()
        }
    }
    
    // MARK: Charts Delegate
    
    func numberOfPoints(inLineGraph graph: BEMSimpleLineGraphView) -> Int {
        if self.chartsData != nil {
            return (self.chartsData.close?.count)!
        }
        
        return 0
    }
    
    func lineGraph(_ graph: BEMSimpleLineGraphView, valueForPointAt index: Int) -> CGFloat {
        return CGFloat(self.chartsData.close![index].floatValue)
    }
    
    func popUpSuffixForlineGraph(_ graph: BEMSimpleLineGraphView) -> String {
        
        return " Date"
    }
}

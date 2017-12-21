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
    
    @IBOutlet var date_label: UILabel!
    @IBOutlet var daily_rate_label: MSNumberScrollAnimatedView!
    
    @IBOutlet var animationButton: VBFPopFlatButton!
    
    var calculatorRef: CalculatorViewController? = nil
    
//    var baseCountry: Currency!
    
    var gradient  : CGGradient?
    var lineGradient  : CGGradient?
    var repo: FixerModel!
    var chartsData: YahooChartModel!
    
    var gotFixerData: Bool = false
    var gotYahooData: Bool = false
    var isMainCurrency: Bool = true
    
    var country1_currency: Currency!
    var country2_currency: Currency!
    
//    static let sharedViewController = RateViewController()
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateWithCurency(notification:)), name: NSNotification.Name(rawValue: CountryViewController.changeCurrencyNotification), object: nil)
    }
    
    
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
        let bottomColor1 = UIColor(hexString: "FFFFFF", alpha: 1.0)
        let gradientColors1 : [CGColor] = [topColor1.cgColor,bottomColor1.cgColor]
        let locations1 : [CGFloat] = [0.0, 1.0]
        
        self.gradient = CGGradient(colorsSpace: colorSpace, colors: gradientColors as CFArray, locations: locations)
        self.lineGradient = CGGradient(colorsSpace: colorSpace, colors: gradientColors1 as CFArray, locations: locations1)
        
        chartView.gradientBottom = self.gradient!
        chartView.gradientLine = self.lineGradient!
        
        
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
        daily_rate_label.font = UIFont(name: "HelveticaNeue-Bold", size: 80)
        daily_rate_label.density = 3
        daily_rate_label.minLength = 3
        
        daily_rate_label.duration  = 0.8
        daily_rate_label.durationOffset = 0.2
        daily_rate_label.isAscending = true
        daily_rate_label.number = NSNumber(value: 0.0)
//        daily_rate_label.startAnimation()
    }
    
    func initData() {
        country1_currency = Currency(rawValue: country1_label.text!)!
        country2_currency = Currency(rawValue: country2_label.text!)!
        requestData()
    }
    
    func reloadData() {
        let model = self.repo
        let date_rate = model?.date?.readDateFromString(formatter: "yyy-mm-dd")
        self.date_label.text = date_rate?.printDateFromDate(formatter: "yyyy-MM-dd")
        
        country1_label.text = country1_currency.rawValue
        country1_image.image = Currency.image(currency: country1_currency)
        
        country2_label.text = country2_currency.rawValue
        country2_image.image = Currency.image(currency: country2_currency)
        
        let value = self.getRateByCurrency(currency1: country1_currency, currency2: country2_currency)
        let valueString = value.clean
        self.daily_rate_label.font = self.getFontSizeByCount(count: valueString.count)
        self.daily_rate_label.number = NSNumber(value: value)
        self.daily_rate_label.startAnimation()
        
    }
    
    func switchData() {
        swap(&country1_image.image, &country2_image.image)
        swap(&country1_label.text, &country2_label.text)
        swap(&country1_currency, &country2_currency)
        let type = self.animationButton.currentButtonType == FlatButtonType.buttonRewindType ? FlatButtonType.buttonFastForwardType : FlatButtonType.buttonRewindType
        self.animationButton.animate(to: type)
        reloadData()
        self.calculatorRef?.swapeCurrency()
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
        self.requestChartsData()
    }
    
    @IBAction func countryButtonClick(button: UIControl) {
        let tag = button.tag
        self.isMainCurrency = tag == 1
        self.calculatorRef?.isMainCurrency = self.isMainCurrency
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
        

//        LodingHelper.sharedHelper.show(view: (self.view))
        
        weak var weakSelf = self
        
        requestChartsData()
        
        fixerProvider.request(fixer.latest(self.country1_label.text!)) { result in
                if case let .success(response) = result {
                    weakSelf?.gotFixerData = true
                    weakSelf?.shouldRemoveLoading()
                    let model = response.mapObject(FixerModel.self) as FixerModel!
                    weakSelf?.repo = model
                    weakSelf?.reloadData()
                }
        }
    }
    
    func requestChartsData() {
        
        LodingHelper.sharedHelper.show(view: self.chartView)
        
        let query = country1_currency.rawValue + country2_currency.rawValue
        weak var weakSelf = self
        yahooProvider.request(Yahoo.chart(query, "1mo")) { (result) in
            if case let .success(response) = result {
                self.gotYahooData = true
                self.shouldRemoveLoading()
                let model = response.mapObject(YahooChartResponseModel.self)
                let data = model?.makeModel()
                weakSelf?.chartsData = data
                weakSelf?.chartView.reloadGraph()
                weakSelf?.checkTrend(data: data!)
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
    
    func popUpSuffixForlineGraph(_ graph: BEMSimpleLineGraphView, at index: UInt) -> String {
        let time = self.chartsData.timestamp![Int(index)]
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let string = date.printDateFromDate(formatter: "  yyyy-MM-dd")
        return string
    }
    
    
    // MARK: Public
    
    @objc func updateWithCurency(notification: NSNotification) {
        let currency = notification.object as! Currency
        if self.isMainCurrency {
            self.country1_currency = currency
        } else {
            self.country2_currency = currency
        }
        let value = self.getRateByCurrency(currency1: country1_currency, currency2: country2_currency)
        calculatorRef?.updateCurrency(currency: currency, isMainCurreny: self.isMainCurrency, rate: value)
        self.reloadData()
        self.requestChartsData()
    }
    
    func getRateByCurrency(currency1:Currency, currency2:Currency) -> Double {
        let rate1 = self.repo.getValue(currency: currency1) == nil ? 1 : self.repo.getValue(currency: currency1)
        let rate2 = self.repo.getValue(currency: currency2) == nil ? 1 : self.repo.getValue(currency: currency2)
        let value = String(format:"%.2f", rate2!/rate1!)
        return Double(value)!
    }
    
    
    func getFontSizeByCount(count: Int) -> UIFont {
        switch count {
        case 0..<5:
            return UIFont(name: "HelveticaNeue-Bold", size: 80)!
        case 5:
            return UIFont(name: "HelveticaNeue-Bold", size: 60)!
        case 6:
            return UIFont(name: "HelveticaNeue-Bold", size: 50)!
        case 7:
            return UIFont(name: "HelveticaNeue-Bold", size: 45)!
        case 8:
            return UIFont(name: "HelveticaNeue-Bold", size: 40)!
            
        default:
            return UIFont(name: "HelveticaNeue-Bold", size: 88)!
        }
    }
}

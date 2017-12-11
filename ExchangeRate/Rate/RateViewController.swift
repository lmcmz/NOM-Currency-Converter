//
//  RateViewController.swift
//  ExchangeRate
//
//  Created by lmcmz on 08/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import UIKit
import Charts

class RateViewController: BaseViewController, ChartViewDelegate {
  
    @IBOutlet var chartView: LineChartView!
    @IBOutlet var exchangeButton: UIControl!
    @IBOutlet var country1: UIControl!
    @IBOutlet var country2: UIControl!
    
    @IBOutlet var country1_image: UIImageView!
    @IBOutlet var country2_image: UIImageView!
    
    @IBOutlet var country1_label: UILabel!
    @IBOutlet var country2_label: UILabel!
    
    @IBOutlet var daily_rate_label: UILabel!
    @IBOutlet var date_label: UILabel!
    @IBOutlet var up_down_image: UIImageView!
    
    var baseCountry: Currency!
    
    var repo: FixerModel!
    
    func initView() {
        chartView.delegate = self
        chartView.pinchZoomEnabled = false
        chartView.doubleTapToZoomEnabled = false
//        chartView.setScaleEnabled(false)
        chartView.dragEnabled = true
//        chartView.setScaleMinima(2.0, scaleY: 1)
        chartView.clipValuesToContentEnabled = true
        chartView.setScaleEnabled(false)
        chartView.xAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.chartDescription?.enabled = false
        
        chartView.legend.enabled = false
        chartView.minOffset = 0
        chartView.animate(xAxisDuration: 0, yAxisDuration: 1.0)
        chartView.data?.highlightEnabled = true
        
        setDataCount(10, range: 20)
    }
    
    func initData() {
        requestData()
    }
    
    func reloadData() {
        let model = self.repo
        
        let date_rate = model?.date?.readDateFromString(formatter: "yyy-mm-dd")
        self.date_label.text = date_rate?.printDateFromDate(formatter: "MMM.dd.yyyy")
        
        let country2_currency = Currency(rawValue: country2_label.text!)
        self.daily_rate_label.text = String(format:"%.2f",(model?.getValue(currency: country2_currency!))!)
        baseCountry = Currency(rawValue: (model?.base)!)
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        let values = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 3)
            return ChartDataEntry(x: Double(i), y: val)
        }
        
        let set1 = LineChartDataSet(values: values, label: nil)
        set1.setColor(ChartColorTemplates.colorFromString("#7FCFDC"))
        
        set1.mode = .cubicBezier
        set1.lineWidth = 1
        set1.lineCapType = .round
        set1.circleRadius = 3
        set1.drawCirclesEnabled = false
        set1.drawValuesEnabled = false
        set1.drawCircleHoleEnabled = true
        set1.drawIconsEnabled = false
        set1.drawHorizontalHighlightIndicatorEnabled = false
        set1.drawValuesEnabled = true
        set1.valueTextColor = .white
        set1.highlightEnabled = true
        set1.highlightLineDashLengths = [5, 2.5]
        
        let gradientColors = [ChartColorTemplates.colorFromString("#353D60").cgColor,
                              ChartColorTemplates.colorFromString("#8AD5E2").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        set1.fillAlpha = 0.3
        set1.fill = Fill(linearGradient: gradient, angle: 90) //.linearGradient(gradient, angle: 90)
        set1.drawFilledEnabled = true
        
        let data = LineChartData(dataSet: set1)
        
        chartView.data = data
    }
    
    func switchData() {
        swap(&country1_image.image, &country2_image.image)
        swap(&country1_label.text, &country2_label.text)
        let country2_currency = Currency(rawValue: country2_label.text!)
        if baseCountry.rawValue == country1_label.text {
            self.daily_rate_label.text = String(format:"%.2f",(self.repo.getValue(currency: country2_currency!))!)
            return
        }
        self.daily_rate_label.text = String(format:"%.2f",1/(self.repo.getValue(currency: country2_currency!))!)
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
        fixerProvider.request(fixer.latest(self.country1_label.text!)) { result in
            do {
                if case let .success(response) = result {
                    let model = try response.mapObject(FixerModel.self) as FixerModel!
                    self.repo = model
                    self.reloadData()
                }
            }
            catch {
                let printableError = error as CustomStringConvertible
                print(printableError)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initView()
    }

}

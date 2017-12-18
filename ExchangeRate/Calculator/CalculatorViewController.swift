//
//  CalculatorViewController.swift
//  ExchangeRate
//
//  Created by lmcmz on 10/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var country1Label: UILabel!
    @IBOutlet var country2Label: UILabel!
    @IBOutlet var calculatorLabel: UILabel!
    
    var haveOperation = true
    var recentOperation:Character = "+"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func buttonDidClick(button:UIControl) {
        let tag = button.tag
        if tag > 9 {
            notNumberButtonClick(tag: tag)
            return
        }
        
        if self.haveOperation {
            let string = self.calculatorLabel.text
            self.calculatorLabel.text = string! + String(tag)
            update()
            return
        }
        
        var string = self.country1Label.text
        if string == "0" {
            string = ""
        }
        self.country1Label.text = string! + String(tag)
    }
    
    func notNumberButtonClick(tag:Int){
        
        switch tag {
        case 10:
            let string = self.country1Label.text
            self.country1Label.text = string! + "."
        case 11:
            self.haveOperation = false
            self.country1Label.text = "0"
            self.country2Label.text = "0"
            self.calculatorLabel.text = ""
        case 12:
            self.haveOperation = true
            let string = self.country1Label.text
            self.calculatorLabel.text = string! + "+"
            self.recentOperation = "+"
        case 13:
            self.haveOperation = true
            let string = self.country1Label.text
            self.calculatorLabel.text = string! + "-"
            self.recentOperation = "-"
        case 14:
            self.haveOperation = true
            let string = self.country1Label.text
            self.calculatorLabel.text = string! + "×"
            self.recentOperation = "×"
        case 15:
            self.haveOperation = true
            let string = self.country1Label.text
            self.calculatorLabel.text = string! + "÷"
            self.recentOperation = "÷"
        default:
            self.country1Label.text = "0"
            self.country2Label.text = "0"
        }
    }
    
    func update() {
        let string = self.calculatorLabel.text
        var stringArray = string?.split(separator: self.recentOperation)
        if stringArray?.count != 2 {
            return
        }
        
        let number1 = Double(stringArray![0])
        let number2 = Double(stringArray![1])
        var result: Double
        
        switch self.recentOperation {
        case "+":
            result = number1! + number2!
        case "-":
            result = number1! - number2!
        case "×":
            result = number1! * number2!
        case "÷":
            result = number1! / number2!
        default:
            result = number1! + number2!
        }
        
        self.country1Label.text = result.clean
        
    }
    
    func appendString(label:UILabel, string:String) {
        let old = label.text
        label.text = old! + string
    }

}
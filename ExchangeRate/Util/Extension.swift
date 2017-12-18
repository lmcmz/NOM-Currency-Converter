//
//  Extension.swift
//  ExchangeRate
//
//  Created by lmcmz on 08/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import Foundation
import UIKit

class Extension {
}

extension String {
    func readDateFromString(formatter: String) -> Date {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = formatter
        let date: Date? = dateFormatterGet.date(from: self)! as Date
        return date! as Date
    }
}

extension Date {
    public func printDateFromDate(formatter: String) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = formatter
        return dateFormatterPrint.string(from: self)
    }
}

extension UIViewController {
    func showChildViewController(childController: UIViewController) {
        self.showChildViewControllerInView(childController: childController, contianerView: self.view)
    }
    
    func showChildViewControllerInView(childController: UIViewController, contianerView: UIView) {
        self.addChildViewController(childController)
        childController.view.frame = contianerView.bounds
        contianerView.addSubview(childController.view)
        childController.didMove(toParentViewController: self)
    }
    
    func removeFromParentViewController() {
        self.willMove(toParentViewController: nil)
        if self.view.superview == nil {
            self.removeFromParentViewController()
        } else {
            self.view.removeFromSuperview()
        }
    }
    
    func moveToTopInParentViewController() {
        self.view.superview?.bringSubview(toFront: self.view)
    }
}

extension UIView {
  class func fromNib<T: UIView>() -> T {
    return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
  }
}

extension UITextField {
    @IBInspectable var placeholderColor: UIColor {
        get {
            guard let currentAttributedPlaceholderColor = attributedPlaceholder?.attribute(NSAttributedStringKey.foregroundColor, at: 0, effectiveRange: nil) as? UIColor else { return UIColor.clear }
            return currentAttributedPlaceholderColor
        }
        set {
            guard let currentAttributedString = attributedPlaceholder else { return }
            let attributes = [NSAttributedStringKey.foregroundColor : newValue]
            
            attributedPlaceholder = NSAttributedString(string: currentAttributedString.string, attributes: attributes)
        }
    }
}

public extension NSObject{
    public class var nameOfClass: String{
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    public var nameOfClass: String{
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
}

extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.2f", self)
    }
}

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.2f", self)
    }
}

//
//  BaseUIControl.swift
//  ExchangeRate
//
//  Created by lmcmz on 19/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import Foundation
import UIKit

class BaseControl: UIControl {
    
    override var isHighlighted: Bool {
        didSet {
            if (isHighlighted) {
                self.backgroundColor = UIColor(white: 0, alpha: 0.1)
            }
            else {
                self.backgroundColor = UIColor(white: 0, alpha: 0.2)
            }
            
        }
    }
}

class BaseDarkControl: UIControl {
    
    override var isHighlighted: Bool {
        didSet {
            if (isHighlighted) {
                self.backgroundColor = UIColor(white: 0, alpha: 0.2)
            }
            else {
                self.backgroundColor = UIColor(white: 0, alpha: 0.3)
            }
            
        }
    }
}

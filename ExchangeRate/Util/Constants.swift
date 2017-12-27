//
//  Constants.swift
//  ExchangeRate
//
//  Created by lmcmz on 08/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import Foundation
import UIKit

enum Language:Int {
    case Chinese = 1,English,Spanish
}

class Constants {
    static let SCREEN_WIDTH : CGFloat = UIScreen.main.bounds.width
    static let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
    
    static let padding : CGFloat = 12
    
    static let supportCurrency = 32 as Int
    static let NavigationBarHeightX = 44
    static let BottomBarHeightX = 34
    
    static let HomePageVCHeight = UIScreen.main.bounds.height - 50 - 44 - 34
    
}

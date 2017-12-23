//
//  YahooModel.swift
//  ExchangeRate
//
//  Created by lmcmz on 19/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import Foundation
import HandyJSON

enum YahooPeriod: Int, HandyJSONEnum {
    case
    fiveD = 0,oneMO,threeMO,oneY,fiveY
    
    static func supportNumber() -> Int {
        return 5
    }
    
    static func getString(period: YahooPeriod) -> String {
        switch period {
        case .fiveD:
            return "5D"
        case .oneMO:
            return "1M"
        case .threeMO:
            return "3M"
        case .oneY:
            return "1Y"
        case .fiveY:
            return "5Y"
        }
    }
    
    static func getRequestString(period: YahooPeriod) -> String {
        switch period {
        case .fiveD:
            return "5d"
        case .oneMO:
            return "1mo"
        case .threeMO:
            return "3mo"
        case .oneY:
            return "1y"
        case .fiveY:
            return "5y"
        }
    }
}

enum YahooFrequency: Int, HandyJSONEnum {
    case
    oneHour = 0, oneDay, oneWeek, oneMonth, threeMonth
    
    static func supportNumber() -> Int {
        return 5
    }
    
    static func getString(frenquency: YahooFrequency) -> String {
        switch frenquency {
        case .oneHour:
            return "1H"
        case .oneDay:
            return "1D"
        case .oneWeek:
            return "1W"
        case .oneMonth:
            return "1M"
        case .threeMonth:
            return "3M"
        }
    }
    
    static func getRequestString(frenquency: YahooFrequency) -> String {
        switch frenquency {
        case .oneHour:
            return "1h"
        case .oneDay:
            return "1d"
        case .oneWeek:
            return "1wk"
        case .oneMonth:
            return "1mo"
        case .threeMonth:
            return "3mo"
        }
    }
}

class YahooAllResponseModel:HandyJSON {
    var list: YahooResponseModel?
    
    required init() {}
}

class YahooResponseModel:HandyJSON {
    var meta: YahooMeta?
    var resources: [YahooResources]?
    
    required init() {}
    
    func getResourceByCurrency(currency:String) -> YahooModel {
        for resource in self.resources! {
            if resource.resource?.fields?.name == currency {
                return (resource.resource?.fields)!
            }
        }
        return YahooModel.init()
    }
}

class YahooMeta: HandyJSON {
    var type: String?
    var start: Int?
    var count: Int?
    
    required init() {}
}

class YahooResources: HandyJSON {
    var resource:YahooResource?
    required init() {}
}

class YahooResource: HandyJSON {
    var classname:String?
    var fields:YahooModel?
    required init() {}
}

class YahooModel:HandyJSON {
    var name: String?
    var price: String?
    var symbol: String?
    var ts: String?
    var type: String?
    var utctime: String?
    var volume: String?
    
    required init() {
        
    }
}

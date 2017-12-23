//
//  YahooModel.swift
//  ExchangeRate
//
//  Created by lmcmz on 19/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import Foundation
import HandyJSON

enum YahooPeriod: String, HandyJSONEnum {
    case
    fiveD,oneMO,threeMO,oneY,fiveY
    
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
}

enum YahooFrenquency: String, HandyJSONEnum {
    case
    halfHour, oneHour, oneDay, oneWeek, threeMonth
    
    static func supportNumber() -> Int {
        return 5
    }
    
    static func getString(frenquency: YahooFrenquency) -> String {
        switch frenquency {
        case .halfHour:
            return "½H"
        case .oneHour:
            return "1H"
        case .oneDay:
            return "1D"
        case .oneWeek:
            return "1W"
        case .threeMonth:
            return "3M"
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

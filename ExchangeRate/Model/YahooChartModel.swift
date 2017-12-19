//
//  YahooChartModel.swift
//  ExchangeRate
//
//  Created by lmcmz on 19/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import Foundation
import HandyJSON

class YahooChartResponseModel: HandyJSON {
    var chart: YahooChartResultModel?
    required init() {}
    
    func makeModel() -> YahooChartModel {
        let model = YahooChartModel()
        let result = self.chart?.result?.first
        let currency = result?.meta?.currency
        let quote = result?.indicators?.quote?.first
        model.currency = currency
        model.timestamp = result?.timestamp
        model.close = quote?.close
        
        return model
    }
}

class YahooChartResultModel: HandyJSON {
    var result:[YahooChartDetailModel]?
    var error: Any?
    
    required init() {}
}

class YahooChartDetailModel: HandyJSON {
    var meta: YahooChartMetaModel?
    var timestamp: [Int]?
    var indicators: YahooChartQuoteModel?
    
    required init() {}
}

class YahooChartQuoteModel: HandyJSON {
    var quote:[YahooChartCloseModel]?
    required init() {}
}

class YahooChartCloseModel: HandyJSON {
    var close:[NSNumber]?
    required init() {}
}

class YahooChartMetaModel: HandyJSON {
    var currency: String?
    var symbol: String?
    var timezone: String?
    var exchangeTimezoneName: String?
    
    required init() {}
}


class YahooChartModel: HandyJSON {
    var currency: String?
    var timestamp: [Int]?
    var close:[NSNumber]?
    
    required init() {
    }
}

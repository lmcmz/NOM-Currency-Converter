//
//  YahooChartModel.swift
//  ExchangeRate
//
//  Created by lmcmz on 19/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import Foundation
import HandyJSON
import Charts

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
    
    func changeToChartsData() -> [ChartDataEntry] {
        var result = [ChartDataEntry]()
        let count = self.close?.count as! Int
        for index in (0..<count) {
            let point = ChartDataEntry(x: Double(self.timestamp![index]), y: Double(truncating: self.close![index]))
            result.append(point)
        }
        return result
    }
}

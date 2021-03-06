//
//  CacheManager.swift
//  ExchangeRate
//
//  Created by lmcmz on 22/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import Foundation

class CacheManager: NSObject {
    static let shareManager = CacheManager()
    static let kCountry1Key = "Exchange.Rate.Country1.key"
    static let kCountry2Key = "Exchange.Rate.Country2.key"
    static let kRateKey = "Exchange.Rate.Currency.key"
    static let kChartKey = "Exchange.Rate.Chart.key"
    static let kChartPeriodKey = "Exchange.Period.Chart.key"
    static let kChartFrenquencyKey = "Exchange.Frenquency.Chart.key"
    static let kLanguageKey = "Exchange.Language.key"
    
    class func setCountryCache(currency1: Currency, currency2: Currency) {
        CacheManager.shareManager.setValue(value: currency1.rawValue, key: kCountry1Key)
        CacheManager.shareManager.setValue(value: currency2.rawValue, key: kCountry2Key)
    }
    
    class func getCountryCache() -> (Currency?,Currency?) {
        var value1 = CacheManager.shareManager.getValue(key: kCountry1Key)
        var value2 = CacheManager.shareManager.getValue(key: kCountry2Key)
        if value1 == nil { value1 = "AUD" }
        if value2 == nil { value2 = "CNY" }
        let country1 = Currency(rawValue: value1!)
        let country2 = Currency(rawValue: value2!)
        return (country1!, country2!)
    }
    
    class func setRateCache(data:FixerModel) {
        let dataString = data.toJSONString()
        CacheManager.shareManager.setValue(value: dataString!, key: kRateKey)
    }
    
    class func getRateCache() -> FixerModel {
        let value = CacheManager.shareManager.getValue(key: kRateKey)
        if value == nil {
            return FixerModel()
        }
        let data = FixerModel.deserialize(from: value)
        return data!
    }
    
    class func setChartsCache(data:YahooChartModel) {
        let dataString = data.toJSONString()
        CacheManager.shareManager.setValue(value: dataString!, key: kChartKey)
    }
    
    class func getChatsCache() -> YahooChartModel {
        let value = CacheManager.shareManager.getValue(key: kChartKey)
        if value == nil {
            return YahooChartModel()
        }
        let data = YahooChartModel.deserialize(from: value)
        return data!
    }
    
    class func setPeriodCache(data:YahooPeriod) {
        let value = String(data.rawValue)
        CacheManager.shareManager.setValue(value: value, key: kChartPeriodKey)
    }
    
    class func getPeriodCache() -> YahooPeriod {
        if !CacheManager.shareManager.checkValue(key: kChartPeriodKey) {
            return YahooPeriod.oneMO
        }
        
        let value = CacheManager.shareManager.getValue(key: kChartPeriodKey)
        let data = YahooPeriod(rawValue: Int(value!)!)
        return data!
    }
    
    class func setFrequencyCache(data:YahooFrequency) {
        let value = String(data.rawValue)
        CacheManager.shareManager.setValue(value: value, key: kChartFrenquencyKey)
    }
    
    class func getFrequencyCache() -> YahooFrequency {
        if !CacheManager.shareManager.checkValue(key: kChartFrenquencyKey) {
            return YahooFrequency.oneDay
        }
        let value = CacheManager.shareManager.getValue(key: kChartFrenquencyKey)
        let data = YahooFrequency(rawValue: Int(value!)!)
        return data!
    }
    
    class func setLanguages(language:Language) {
        let value = String(language.rawValue)
        CacheManager.shareManager.setValue(value: value, key: kLanguageKey)
    }
    
    class func getLanguage() -> Language {
        if !CacheManager.shareManager.checkValue(key: kLanguageKey) {
            return Language.English
        }
        let value = CacheManager.shareManager.getValue(key: kLanguageKey)
        let data = Language(rawValue: Int(value!)!)
        return data!
    }
    
    func setValue(value: String, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func checkValue(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    func getValue(key: String) -> String? {
        if self.checkValue(key: key) {
            return UserDefaults.standard.value(forKey: key) as! String?
        }
        return nil
    }
}

//
//  FixerModel.swift
//  ExchangeRate
//
//  Created by lmcmz on 10/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import Foundation
import HandyJSON

struct AllCurrency: HandyJSON {
    var AUD: Double?
    var BGN: Double?
    var BRL: Double?
    var CAD: Double?
    var CHF: Double?
    var CNY: Double?
    var CZK: Double?
    var DKK: Double?
    var GBP: Double?
    var HKD: Double?
    var HRK: Double?
    var HUF: Double?
    var IDR: Double?
    var ILS: Double?
    var INR: Double?
    var JPY: Double?
    var KRW: Double?
    var MXN: Double?
    var MYR: Double?
    var NOK: Double?
    var NZD: Double?
    var PHP: Double?
    var PLN: Double?
    var RON: Double?
    var RUB: Double?
    var SEK: Double?
    var SGD: Double?
    var THB: Double?
    var TRY: Double?
    var USD: Double?
    var ZAR: Double?
    var EUR: Double?
}

class FixerModel: HandyJSON {
    var base: String?
    var date: String?
    var rates: AllCurrency?
    
    required init() {}
    
    func getValue(currency: Currency) -> Double? {
        switch currency {
        case .AUD:
            return self.rates?.AUD
        case .BGN:
            return self.rates?.BGN
        case .BRL:
            return self.rates?.BRL
        case .CAD:
            return self.rates?.CAD
        case .CHF:
            return self.rates?.CHF
        case .CNY:
            return self.rates?.CNY
        case .CZK:
            return self.rates?.CZK
        case .DKK:
            return self.rates?.DKK
        case .GBP:
            return self.rates?.GBP
        case .HKD:
            return self.rates?.HKD
        case .HRK:
            return self.rates?.HRK
        case .HUF:
            return self.rates?.HUF
        case .IDR:
            return self.rates?.IDR
        case .ILS:
            return self.rates?.ILS
        case .INR:
            return self.rates?.INR
        case .JPY:
            return self.rates?.JPY
        case .KRW:
            return self.rates?.KRW
        case .MXN:
            return self.rates?.MXN
        case .MYR:
            return self.rates?.MYR
        case .NOK:
            return self.rates?.NOK
        case .NZD:
            return self.rates?.NZD
        case .PHP:
            return self.rates?.PHP
        case .PLN:
            return self.rates?.PLN
        case .RON:
            return self.rates?.RON
        case .RUB:
            return self.rates?.RUB
        case .SEK:
            return self.rates?.SEK
        case .SGD:
            return self.rates?.SGD
        case .THB:
            return self.rates?.THB
        case .TRY:
            return self.rates?.TRY
        case .USD:
            return self.rates?.USD
        case .ZAR:
            return self.rates?.ZAR
        case .EUR:
            return self.rates?.EUR
        default:
            return self.rates?.CNY
        }
    }
}

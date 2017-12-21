//
//  Currency.swift
//  ExchangeRate
//
//  Created by lmcmz on 11/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import Foundation
import HandyJSON

enum Currency: String, HandyJSONEnum {
    case
    AUD,BGN,BRL,CAD,CHF,
    CNY,CZK,DKK,GBP,HKD,
    HRK,HUF,IDR,ILS,INR,
    JPY,KRW,MXN,MYR,NOK,
    NZD,PHP,PLN,RON,RUB,
    SEK,SGD,THB,TRY,USD,
    ZAR,EUR,BIT
    
    static let supportCurrency : [Currency] = [    .CNY, .USD, .EUR, .CAD, .NZD,
                                                   .AUD, .HKD, .CZK, .DKK, .MXN,
                                                   .HRK, .HUF, .IDR, .ILS, .INR,
                                                   .JPY, .KRW, .GBP, .MYR, .NOK,
                                                   .CHF, .PHP, .PLN, .RON, .RUB,
                                                   .SEK, .SGD, .THB, .TRY, .BGN,
                                                   .ZAR, .BRL]
    
    static func symbol(currency: Currency) -> String? {
        switch currency {
        case .AUD:
            return "$"
        case .BGN:
            return "лв"
        case .BRL:
            return "R$"
        case .CAD:
            return "$"
        case .CHF:
            return "Fr"
        case .CNY:
            return "￥"
        case .CZK:
            return "Kč"
        case .DKK:
            return "kr."
        case .GBP:
            return "£"
        case .HKD:
            return "HK$"
        case .HRK:
            return "kn"
        case .HUF:
            return "Ft"
        case .IDR:
            return "Rp"
        case .ILS:
            return "₪"
        case .INR:
            return "₹"
        case .JPY:
            return "¥"
        case .KRW:
            return "₩"
        case .MXN:
            return "$"
        case .MYR:
            return "RM"
        case .NOK:
            return "kr"
        case .NZD:
            return "$"
        case .PHP:
            return "₱"
        case .PLN:
            return "zł"
        case .RON:
            return "lei"
        case .RUB:
            return "₽"
        case .SEK:
            return "kr"
        case .SGD:
            return "$"
        case .THB:
            return "฿"
        case .TRY:
            return "₺"
        case .USD:
            return "$"
        case .ZAR:
            return "R"
        case .EUR:
            return "€"
        case .BIT:
            return "₿"
        }
    }
    
    static func image(currency: Currency) -> UIImage? {
        switch currency {
        case .AUD:
            return UIImage(named: "234-australia")
        case .BGN:
            return UIImage(named: "168-bulgaria")
        case .BRL:
            return UIImage(named: "255-brazil")
        case .CAD:
            return UIImage(named: "243-canada")
        case .CHF:
            return UIImage(named: "205-switzerland")
        case .CNY:
            return UIImage(named: "034-china")
        case .CZK:
            return UIImage(named: "149-czech-republic")
        case .DKK:
            return UIImage(named: "174-denmark")
        case .GBP:
            return UIImage(named: "260-united-kingdom")
        case .HKD:
            return UIImage(named: "183-hong-kong")
        case .HRK:
            return UIImage(named: "164-croatia")
        case .HUF:
            return UIImage(named: "115-hungary")
        case .IDR:
            return UIImage(named: "209-indonesia")
        case .ILS:
            return UIImage(named: "155-israel")
        case .INR:
            return UIImage(named: "246-india")
        case .JPY:
            return UIImage(named: "063-japan")
        case .KRW:
            return UIImage(named: "094-south-korea")
        case .MXN:
            return UIImage(named: "252-mexico")
        case .MYR:
            return UIImage(named: "118-malasya")
        case .NOK:
            return UIImage(named: "143-norway")
        case .NZD:
            return UIImage(named: "121-new-zealand")
        case .PHP:
            return UIImage(named: "192-philippines")
        case .PLN:
            return UIImage(named: "211-poland")
        case .RON:
            return UIImage(named: "109-romania")
        case .RUB:
            return UIImage(named: "248-russia")
        case .SEK:
            return UIImage(named: "184-sweden")
        case .SGD:
            return UIImage(named: "230-singapore")
        case .THB:
            return UIImage(named: "238-thailand")
        case .TRY:
            return UIImage(named: "218-turkey")
        case .USD:
            return UIImage(named: "263-united-states")
        case .ZAR:
            return UIImage(named: "200-south-africa")
        case .EUR:
            return UIImage(named: "259-european-union")
        case .BIT:
            return UIImage(named: "bitcoin")
        }
    }
}

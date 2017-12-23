//
//  YahooRateAPI.swift
//  ExchangeRate
//
//  Created by lmcmz on 19/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import Foundation
import Moya

// MARK: - Provider setup

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

let yahooProvider = MoyaProvider<Yahoo>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

//let yahooChartProvider = MoyaProvider<YahooChart>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

// MARK: - Provider support

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

public enum Yahoo {
    case currency
    case chart(String, String, String)
}

extension Yahoo: TargetType {
    public var baseURL: URL { return URL(string: "https:/")! }
    public var path: String {
        switch self {
        case .currency:
            return "finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote"
        case .chart(let base, _, _):
            return "query1.finance.yahoo.com/v7/finance/chart/\(base)=X"
        }
    }
    public var method: Moya.Method {
        return .get
    }
    public var task: Task {
        switch self {
        case .currency:
            return .requestParameters(parameters: ["format":"json"], encoding: URLEncoding.default)
        case .chart(_, let range, let frequency):
            return .requestParameters(parameters: ["range": range, "interval": frequency, "indicators" : "close", "includeTimestamps":"true" , "includePrePost":"false", "corsDomain":"finance.yahoo.com"], encoding: URLEncoding.default)
        }
    }
    public var validate: Bool {
        switch self {
        case .currency:
            return true
        default:
            return false
        }
    }
    public var sampleData: Data {
        switch self {
        case .currency:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        case .chart(let name):
            return "{\"login\": \"\(name)\", \"id\": 100}".data(using: String.Encoding.utf8)!
        }
    }
    public var headers: [String: String]? {
        return nil
    }
}

//public enum YahooChart {
//    case chart(String)
//}

//extension YahooChart: TargetType {
//    public var baseURL: URL {
//        return URL(string: "https:/")!
//    }
//
//    public var path: String {
//        switch self {
//        case .chart(let base):
//            return "query1.finance.yahoo.com/v7/finance/chart/\(base)=X?range=5d&interval=1h&indicators=close&includeTimestamps=true&includePrePost=false&corsDomain=finance.yahoo.com"
//        }
//    }
//
//    public var method: Moya.Method {
//        return .get
//    }
//
//    public var sampleData: Data {
//        return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
//    }
//
//    public var task: Task {
//        switch self {
//        case .chart(let base):
//            return .requestParameters(parameters: ["base": base], encoding: URLEncoding.default)
//        }
//    }
//
//    public var headers: [String : String]? {
//        return nil
//    }

    
//}


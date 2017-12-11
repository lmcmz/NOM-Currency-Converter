//
//  ExchangeRateAPI.swift
//  ExchangeRate
//
//  Created by lmcmz on 10/12/2017.
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

let fixerProvider = MoyaProvider<fixer>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

// MARK: - Provider support

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

public enum fixer {
    case latest(String)
    case date(String)}

extension fixer: TargetType {
    public var baseURL: URL { return URL(string: "https://api.fixer.io")! }
    public var path: String {
        switch self {
        case .latest(let base):
            return "/latest"
        case .date(let date):
            return "/\(date)"
        }
    }
    public var method: Moya.Method {
        return .get
    }
    public var task: Task {
        switch self {
        case .latest(let base):
            return .requestParameters(parameters: ["base": base], encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    public var validate: Bool {
        switch self {
        case .latest:
            return true
        default:
            return false
        }
    }
    public var sampleData: Data {
        switch self {
        case .latest:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        case .date(let name):
            return "{\"login\": \"\(name)\", \"id\": 100}".data(using: String.Encoding.utf8)!
        }
    }
    public var headers: [String: String]? {
        return nil
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}

// MARK: - Response Handlers

extension Moya.Response {
    func mapNSArray() throws -> NSArray {
        let any = try self.mapJSON()
        guard let array = any as? NSArray else {
            throw MoyaError.jsonMapping(self)
        }
        return array
    }
}

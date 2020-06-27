//
//  WeatherAPI.swift
//  Models
//
//  Created by am10 on 2020/06/27.
//  Copyright © 2020 am10. All rights reserved.
//

import Foundation

public class WeatherAPI {
    private let apiClient: APIClient

    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    public func getWeather(cityId: String, completion: @escaping (Result<Weather, APIError>) -> Void) {
        apiClient.requestDecodable(WeatherAPIRequest.getWeather(cityId: cityId), completion: completion)
    }
}

public enum WeatherAPIRequest: Request {
    case getWeather(cityId: String)
    
    public var baseURL: URL {
        #if DEBUG
          // デバッグ（必要であればここでURLを開発用途化に変える）*別モジュールなのでDUMMYは使えない
          return URL(string: "http://weather.livedoor.com/forecast/webservice/json")!
        #else
          // 本番
          return URL(string: "http://weather.livedoor.com/forecast/webservice/json")!
        #endif
    }

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "v1"
    }

    public var parameter: [String: Any] {
        switch self {
        case .getWeather(let cityId):
            return ["city": cityId]
        }
    }
}

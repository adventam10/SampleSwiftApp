//
//  DummyAPIClient.swift
//  Models
//
//  Created by am10 on 2020/06/27.
//  Copyright © 2020 am10. All rights reserved.
//

import Foundation

public final class DummyAPIClient: APIClient {
    public static let shared = DummyAPIClient()

    private init() {}

    public func send(_ request: Request, completion: @escaping (Result<Data, APIError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            guard let data = self.dummyData(of: request) else {
                completion(.failure(.invalidData))
                return
            }
            completion(.success(data))
        }
    }

    public func requestDecodable<T>(_ request: Request, completion: @escaping (Result<T, APIError>) -> Void) where T: Decodable {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            guard let data = self.dummyData(of: request),
                let result = try? JSONDecoder().decode(T.self, from: data) else {
                    completion(.failure(.invalidData))
                    return
            }
            completion(.success(result))
        }
    }
}

extension DummyAPIClient {
    private func dummyData(of request: Request) -> Data? {
        if let request = request as? WeatherAPIRequest {
            switch request {
            case .getWeather:
                return loadData(fileName: "get_weather_city_400010")
            }
        } else if let request = request as? AvatarAPIRequest {
            switch request {
            case .getAvatar:
                return loadData(fileName: "get_avatar", fileExtension: "svg")
            }
        }
        return nil
    }

    private func loadData(fileName: String, fileExtension: String = "json") -> Data {
        let bundle = Bundle(for: DummyAPIClient.self)
        let url = bundle.url(forResource: fileName, withExtension: fileExtension)!
        return try! Data(contentsOf: url)
    }
}

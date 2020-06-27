//
//  StartPresentationModel.swift
//  SampleSwiftApp
//
//  Created by am10 on 2020/06/27.
//  Copyright © 2020 am10. All rights reserved.
//

import Foundation
import DIKit
import Models

final class StartPresentationModel: Injectable {
    struct Dependency {
        let resolver: AppResolver
        let apiClient: APIClient
    }

    private let resolver: AppResolver
    private let weatherAPI: WeatherAPI
    private let cityDataList: [CityData]

    static func loadCityDataList() -> [CityData] {
        guard let url = R.file.cityDataListJson(),
            let data = try? Data(contentsOf: url),
            let result = try? JSONDecoder().decode([CityData].self, from: data) else {
                assertionFailure("CityDataList.jsonの形式が不正")
                return []
        }
        return result
    }

    init(dependency: Dependency) {
        self.resolver = dependency.resolver
        self.weatherAPI = .init(apiClient: dependency.apiClient)
        self.cityDataList = Self.loadCityDataList()
    }

    func getWeather(completion: @escaping (Result<Weather, APIError>) -> Void) {
        guard let target = cityDataList.shuffled().first else {
            assertionFailure("CityDataListが空")
            completion(.failure(.invalidData))
            return
        }
        log?.info("\(target.name)の天気をリクエスト")
        weatherAPI.getWeather(cityId: target.cityId) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

    func makeWeatherPresentationModel(weather: Any?) -> WeatherPresentationModel? {
        guard let weather = weather as? Weather else {
            assertionFailure("天気情報が取得できていない")
            return nil
        }
        return resolver.resolveWeatherPresentationModel(weather: weather, pattern: .fromStart)
    }

    func makeHistoryPresentationModel() -> HistoryPresentationModel {
        return resolver.resolveHistoryPresentationModel()
    }
}

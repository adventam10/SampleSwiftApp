//
//  WeatherPresentationModel.swift
//  SampleSwiftApp
//
//  Created by am10 on 2020/06/27.
//  Copyright © 2020 am10. All rights reserved.
//

import Foundation
import DIKit
import Models

enum WeatherViewPattern {
    case fromStart
    case fromHistory
}

final class WeatherPresentationModel: Injectable {
    struct Dependency {
        let apiClient: APIClient
        let database: Database
        let weather: Weather
        let pattern: WeatherViewPattern
    }

    private let avatarAPI: AvatarAPI
    private let historyRepository: HistoryRepository
    private let weather: Weather
    private let pattern: WeatherViewPattern

    var formattedWeatherText: String {
        return "\(weather.date) \(weather.title) は \(weather.telop) です。"
    }

    var isSaveButtonShown: Bool {
        switch pattern {
        case .fromStart:
            return true
        case .fromHistory:
            return false
        }
    }

    init(dependency: Dependency) {
        self.avatarAPI = .init(apiClient: dependency.apiClient)
        self.historyRepository = .init(database: dependency.database)
        self.weather = dependency.weather
        self.pattern = dependency.pattern
    }

    func getAvatar(completion: @escaping (Result<Data, APIError>) -> Void) {
        avatarAPI.getAvatar(avatarType: .random) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

    func saveWeather() {
        historyRepository.addWeather(weather)
    }
}

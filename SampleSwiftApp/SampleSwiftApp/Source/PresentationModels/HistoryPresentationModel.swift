//
//  HistoryPresentationModel.swift
//  SampleSwiftApp
//
//  Created by am10 on 2020/06/27.
//  Copyright © 2020 am10. All rights reserved.
//

import Foundation
import DIKit
import Models

final class HistoryPresentationModel: Injectable {
    struct Dependency {
        let resolver: AppResolver
        let database: Database
        let apiClient: APIClient
    }

    private let resolver: AppResolver
    private let avatarAPI: AvatarAPI
    private let historyRepository: HistoryRepository
    private var histories: [History]

    var isHistoryListShown: Bool {
        return !histories.isEmpty
    }

    var numberOfHistories: Int {
        return histories.count
    }

    init(dependency: Dependency) {
        self.resolver = dependency.resolver
        self.historyRepository = .init(database: dependency.database)
        self.avatarAPI = .init(apiClient: dependency.apiClient)
        self.histories = historyRepository.fetchAll()
    }

    func getAvatar(completion: @escaping (Result<Data, APIError>) -> Void) {
        avatarAPI.getAvatar(avatarType: .random) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

    func history(at index: Int) -> History {
        return histories[index]
    }

    func removeHistory(at index: Int) {
        let target = histories[index]
        historyRepository.remove(target)
        histories.remove(at: index)
    }

    func makeWeatherPresentationModel(historyIndex: Int) -> WeatherPresentationModel? {
        let history = histories[historyIndex]
        guard let data = history.weather,
        let weather = try? JSONDecoder().decode(Weather.self, from: data) else {
            assertionFailure("履歴の天気情報が型不正")
            return nil
        }
        return resolver.resolveWeatherPresentationModel(weather: weather, pattern: .fromHistory)
    }
}

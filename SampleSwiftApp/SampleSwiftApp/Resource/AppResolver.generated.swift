//
//  Resolver.swift
//  Generated by dikitgen.
//

import DIKit
import Foundation
import Models

extension AppResolver {

    func resolveAPIClient() -> APIClient {
        return provideAPIClient()
    }

    func resolveAppResolver() -> AppResolver {
        return provideResolver()
    }

    func resolveDatabase() -> Database {
        return provideDatabase()
    }

    func resolveHistoryPresentationModel() -> HistoryPresentationModel {
        let appResolver = resolveAppResolver()
        let database = resolveDatabase()
        let apiClient = resolveAPIClient()
        return HistoryPresentationModel(dependency: .init(resolver: appResolver, database: database, apiClient: apiClient))
    }

    func resolveStartPresentationModel() -> StartPresentationModel {
        let appResolver = resolveAppResolver()
        let apiClient = resolveAPIClient()
        return StartPresentationModel(dependency: .init(resolver: appResolver, apiClient: apiClient))
    }

    func resolveWeatherPresentationModel(weather: Weather, pattern: WeatherViewPattern) -> WeatherPresentationModel {
        let apiClient = resolveAPIClient()
        let database = resolveDatabase()
        return WeatherPresentationModel(dependency: .init(apiClient: apiClient, database: database, weather: weather, pattern: pattern))
    }

}


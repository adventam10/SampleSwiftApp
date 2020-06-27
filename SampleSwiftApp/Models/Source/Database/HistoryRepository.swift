//
//  HistoryRepository.swift
//  Models
//
//  Created by am10 on 2020/06/27.
//  Copyright © 2020 am10. All rights reserved.
//

import Foundation

public struct HistoryRepository {
    public typealias Object = History

    private let database: Database

    public init(database: Database) {
        self.database = database
    }

    public func fetchAll() -> [Object] {
        return database.fetchAll(Object.self)
    }

    public func addWeather(_ weather: Weather) {
        let history = History()
        history.weather = try? JSONEncoder().encode(weather)
        history.name = "\(weather.date) \(weather.title)"
        database.add(history)
    }

    public func remove(_ object: Object) {
        database.remove(object)
    }
}

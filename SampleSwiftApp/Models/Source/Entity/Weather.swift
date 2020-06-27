//
//  Weather.swift
//  Models
//
//  Created by am10 on 2020/06/27.
//  Copyright © 2020 am10. All rights reserved.
//

import Foundation

public struct Weather {
    public let title: String
    public let area: String
    public let city: String
    public let prefecture: String
    public let date: String
    public let dateLabel: String
    public let telop: String
}

extension Weather: Codable {
    private enum CodingKeys: String, CodingKey {
        case title
        case forecasts
        case location
    }

    private enum ForecastsKeys: String, CodingKey {
        case date
        case dateLabel
        case telop
    }

    private enum LocationKeys: String, CodingKey {
        case area
        case city
        case prefecture
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try values.decode(String.self, forKey: .title)

        let location = try values.nestedContainer(keyedBy: LocationKeys.self, forKey: .location)
        self.area = try location.decode(String.self, forKey: .area)
        self.city = try location.decode(String.self, forKey: .city)
        self.prefecture = try location.decode(String.self, forKey: .prefecture)

        var forecasts = try values.nestedUnkeyedContainer(forKey: .forecasts)
        let forecast = try forecasts.nestedContainer(keyedBy: ForecastsKeys.self)
        self.date = try forecast.decode(String.self, forKey: .date)
        self.dateLabel = try forecast.decode(String.self, forKey: .dateLabel)
        self.telop = try forecast.decode(String.self, forKey: .telop)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)

        var location = container.nestedContainer(keyedBy: LocationKeys.self, forKey: .location)
        try location.encode(area, forKey: .area)
        try location.encode(city, forKey: .city)
        try location.encode(prefecture, forKey: .prefecture)

        var forecasts = container.nestedUnkeyedContainer(forKey: .forecasts)
        var forecast = forecasts.nestedContainer(keyedBy: ForecastsKeys.self)
        try forecast.encode(date, forKey: .date)
        try forecast.encode(dateLabel, forKey: .dateLabel)
        try forecast.encode(telop, forKey: .telop)
    }
}

//
//  WeatherSpec.swift
//  ModelsTests
//
//  Created by am10 on 2020/06/27.
//  Copyright © 2020 am10. All rights reserved.
//

import Quick
import Nimble

@testable import Models

final class WeatherSpec: QuickSpec {

    override func spec() {
        describe("initFromDecoder") {
            let jsonText =
            """
            {
            "title": "title",
            "location": {"area": "area", "city": "city", "prefecture": "prefecture"},
            "forecasts": [
            {"date": "date1", "dateLabel": "dateLabel1", "telop": "telop1"},
            {"date": "date2", "dateLabel": "dateLabel2", "telop": "telop2"}
            ]
            }
            """
            let jsonData = jsonText.data(using: .utf8)
            let weather = try! JSONDecoder().decode(Weather.self, from: jsonData!)
            it ("is decodable") {
                expect(weather.title).to(equal("title"))
                expect(weather.area).to(equal("area"))
                expect(weather.city).to(equal("city"))
                expect(weather.prefecture).to(equal("prefecture"))
                expect(weather.date).to(equal("date1"))
                expect(weather.dateLabel).to(equal("dateLabel1"))
                expect(weather.telop).to(equal("telop1"))
            }
        }

        describe("encodeToEncoder") {
            let jsonText =
            """
            {
            "title": "title",
            "location": {"prefecture": "prefecture", "city": "city", "area": "area"},
            "forecasts": [
            {"date": "date", "dateLabel": "dateLabel", "telop": "telop"}
            ]
            }
            """.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "")
            let weather = Weather(title: "title", area: "area", city: "city",
                                  prefecture: "prefecture", date: "date",
                                  dateLabel: "dateLabel", telop: "telop")
            let jsonData = try! JSONEncoder().encode(weather)
            it ("is encodable") {
                expect(String(data: jsonData, encoding: .utf8)!).to(equal(jsonText))
            }
        }
    }
}

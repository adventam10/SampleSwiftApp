//
//  WeatherPresentationModelSpec.swift
//  SampleSwiftAppTests
//
//  Created by am10 on 2020/06/27.
//  Copyright © 2020 am10. All rights reserved.
//

import Quick
import Nimble

@testable import SampleSwiftApp
@testable import Models

final class WeatherPresentationModelSpec: QuickSpec {

    private let resolver = TestResolver()

    override func spec() {
        describe("isSaveButtonShown") {
            context("when pattern is fromStart") {
                let presentationModel = makeWeatherPresentationModel(pattern: .fromStart)
                it ("returns true") {
                    expect(presentationModel.isSaveButtonShown).to(beTrue())
                }
            }

            context("when pattern is fromHistory") {
                let presentationModel = makeWeatherPresentationModel(pattern: .fromHistory)
                it ("returns false") {
                    expect(presentationModel.isSaveButtonShown).to(beFalse())
                }
            }
        }

        describe("formattedWeatherText") {
            let presentationModel = makeWeatherPresentationModel(pattern: .fromStart)
            it ("returns format weather.date Space weather.title Space は Space weather.telop Space です。") {
                expect(presentationModel.formattedWeatherText).to(equal("date title は telop です。"))
            }
        }
    }
}

extension WeatherPresentationModelSpec {
    private func makeWeatherPresentationModel(pattern: WeatherViewPattern) -> WeatherPresentationModel {
        let weather = Weather(title: "title", area: "area", city: "city",
                              prefecture: "prefecture", date: "date",
                              dateLabel: "dateLabel", telop: "telop")
        return .init(dependency: .init(apiClient: resolver.provideAPIClient(),
                                       database: resolver.provideDatabase(),
                                       weather: weather,
                                       pattern: pattern))
    }
}

//
//  EqualWeatherAPIRequest.swift
//  ModelsTests
//
//  Created by am10 on 2020/06/27.
//  Copyright © 2020 am10. All rights reserved.
//

import Foundation
import Nimble

@testable import Models

func equal(_ expectedWeatherAPIRequest: WeatherAPIRequest) -> Predicate<WeatherAPIRequest> {
    return Predicate.define("equal <\(stringify(expectedWeatherAPIRequest))>") {
        actualExpression, message in
        guard let actualWeatherAPIRequest = try actualExpression.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }
        return PredicateResult(bool: actualWeatherAPIRequest == expectedWeatherAPIRequest, message: message)
    }
}

private func == (lhs: WeatherAPIRequest, rhs: WeatherAPIRequest) -> Bool {
    switch (lhs, rhs) {
    case (.getWeather(let lCityId), .getWeather(let rCityId)):
        return lCityId == rCityId
    }
}

//
//  WeatherAPISpec.swift
//  ModelsTests
//
//  Created by am10 on 2020/06/27.
//  Copyright © 2020 am10. All rights reserved.
//

import Quick
import Nimble

@testable import Models

final class WeatherAPISpec: QuickSpec {

    override func spec() {
        // MARK: - WeatherAPIRequest

        describe("WeatherAPIRequest") {
            describe("baseURL") {
                context("when WeatherAPIRequest is getWeather") {
                    let api = WeatherAPIRequest.getWeather(cityId: "")
                    it ("returns any URL") {
                        expect(api.baseURL).to(equal(URL(string: "http://weather.livedoor.com/forecast/webservice/json")!))
                    }
                }
            }

            describe("method") {
                context("when WeatherAPIRequest is getWeather") {
                    let api = WeatherAPIRequest.getWeather(cityId: "")
                    it ("returns get") {
                        expect(api.method).to(equal(.get))
                    }
                }
            }

            describe("path") {
                context("when WeatherAPIRequest is getWeather") {
                    let api = WeatherAPIRequest.getWeather(cityId: "")
                    it ("returns v1") {
                        expect(api.path).to(equal("v1"))
                    }
                }
            }

            describe("headerFields") {
                context("when WeatherAPIRequest is getWeather") {
                    let api = WeatherAPIRequest.getWeather(cityId: "")
                    it ("returns empty") {
                        expect(api.headerFields).to(beEmpty())
                    }
                }
            }

            describe("parameter") {
                context("when WeatherAPIRequest is getWeather") {
                    let cityId = "cityId"
                    let api = WeatherAPIRequest.getWeather(cityId: cityId)
                    it ("has count 1") {
                        expect(api.parameter).to(haveCount(1))
                    }

                    it ("sets city") {
                        expect(api.parameter["city"] as? String).to(equal(cityId))
                    }
                }
            }

            describe("timeout") {
                context("when WeatherAPIRequest is getWeather") {
                    let api = WeatherAPIRequest.getWeather(cityId: "")
                    it ("returns 65") {
                        expect(api.timeout).to(equal(65))
                    }
                }
            }

            describe("contentType") {
                context("when WeatherAPIRequest is getWeather") {
                    let api = WeatherAPIRequest.getWeather(cityId: "")
                    it ("returns empty") {
                        expect(api.contentType).to(beEmpty())
                    }
                }
            }

            describe("accept") {
                context("when WeatherAPIRequest is getWeather") {
                    let api = WeatherAPIRequest.getWeather(cityId: "")
                    it ("returns empty") {
                        expect(api.accept).to(beEmpty())
                    }
                }
            }
        }

        // MARK: - WeatherAPI

        describe("WeatherAPI") {
            describe("getWeatherWithCityId") {
                let spy = APIClientSpy()
                let cityId = "cityId"
                let api = WeatherAPI(apiClient: spy)
                api.getWeather(cityId: cityId) { _ in }
                let passed = spy.requestDecodablePassedRequest as? WeatherAPIRequest
                it ("passes getWeatherWithCity request to the API client") {
                    expect(passed).to(equal(.getWeather(cityId: cityId)))
                }
            }
        }
    }
}

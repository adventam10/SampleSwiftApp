//
//  CityDataSpec.swift
//  ModelsTests
//
//  Created by am10 on 2020/06/27.
//  Copyright © 2020 am10. All rights reserved.
//

import Quick
import Nimble

@testable import Models

final class CityDataSpec: QuickSpec {

    override func spec() {
        describe("initFromDecoder") {
            let jsonText =
            """
            {"area": 1, "cityId": "cityId", "name": "name"}
            """
            let jsonData = jsonText.data(using: .utf8)
            let cityData = try! JSONDecoder().decode(CityData.self, from: jsonData!)
            it ("is decodable") {
                expect(cityData.area).to(equal(1))
                expect(cityData.cityId).to(equal("cityId"))
                expect(cityData.name).to(equal("name"))
            }
        }
    }
}

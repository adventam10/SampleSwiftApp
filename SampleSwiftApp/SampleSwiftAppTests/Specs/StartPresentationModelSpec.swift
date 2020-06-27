//
//  StartPresentationModelSpec.swift
//  SampleSwiftAppTests
//
//  Created by am10 on 2020/06/27.
//  Copyright © 2020 am10. All rights reserved.
//

import Quick
import Nimble

@testable import SampleSwiftApp

final class StartPresentationModelSpec: QuickSpec {

    override func spec() {
        describe("loadCityDataList") {
            it ("has count 47") {
                expect(StartPresentationModel.loadCityDataList()).to(haveCount(47))
            }
        }
    }
}

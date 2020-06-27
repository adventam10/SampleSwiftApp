//
//  HistoryPresentationModelSpec.swift
//  SampleSwiftAppTests
//
//  Created by am10 on 2020/06/27.
//  Copyright © 2020 am10. All rights reserved.
//

import Quick
import Nimble

@testable import SampleSwiftApp
@testable import Models

final class HistoryPresentationModelSpec: QuickSpec {

    private let resolver = TestResolver()

    override func spec() {
        describe("isHistoryListShown") {
            context("when histories is empty") {
                let database = DummyDatabase()
                let presentationModel = makeHistoryPresentationModel(database: database)
                it ("returns false") {
                    expect(presentationModel.isHistoryListShown).to(beFalse())
                }
            }

            context("when histories is not empty") {
                let database = DummyDatabase()
                database.add(History())
                let presentationModel = makeHistoryPresentationModel(database: database)
                it ("returns true") {
                    expect(presentationModel.isHistoryListShown).to(beTrue())
                }
            }
        }

        describe("numberOfHistories") {
            context("when histories is empty") {
                let database = DummyDatabase()
                database.add(History())
                database.add(History())
                database.add(History())
                let presentationModel = makeHistoryPresentationModel(database: database)
                it ("returns histories count") {
                    expect(presentationModel.numberOfHistories).to(equal(3))
                }
            }
        }
    }
}

extension HistoryPresentationModelSpec {
    private func makeHistoryPresentationModel(database: Database? = nil) -> HistoryPresentationModel {
        return .init(dependency: .init(resolver: resolver,
                                       database: database ?? resolver.provideDatabase(),
                                       apiClient: resolver.resolveAPIClient()))
    }
}

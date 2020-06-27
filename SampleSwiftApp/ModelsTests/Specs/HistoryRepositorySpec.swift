//
//  HistoryRepositorySpec.swift
//  ModelsTests
//
//  Created by am10 on 2020/06/27.
//  Copyright © 2020 am10. All rights reserved.
//

import Quick
import Nimble

@testable import Models

final class HistoryRepositorySpec: QuickSpec {

    override func spec() {
        describe("fetchAll") {
            context("when histories is empty") {
                let database = DummyDatabase()
                let repository = HistoryRepository(database: database)
                it ("returns empty") {
                    expect(repository.fetchAll()).to(beEmpty())
                }
            }

            context("when histories is not empty") {
                let database = DummyDatabase()
                database.add(History())
                database.add(History())
                database.add(History())
                let repository = HistoryRepository(database: database)
                it ("has count 3") {
                    expect(repository.fetchAll()).to(haveCount(3))
                }
            }
        }

        describe("addWeatherWithWeather") {
            let database = DummyDatabase()
            database.add(History())
            database.add(History())
            let repository = HistoryRepository(database: database)
            repository.addWeather(.init(title: "", area: "", city: "", prefecture: "", date: "", dateLabel: "", telop: ""))
            it ("adds target") {
                expect(repository.fetchAll()).to(haveCount(3))
            }
        }

        describe("removeWithObject") {
            let database = DummyDatabase()
            let target = History()
            database.add(History())
            database.add(target)
            database.add(History())
            let repository = HistoryRepository(database: database)
            repository.remove(target)
            it ("removes target") {
                expect(repository.fetchAll()).to(haveCount(2))
                expect(repository.fetchAll()).toNot(contain(target))
            }
        }
    }
}

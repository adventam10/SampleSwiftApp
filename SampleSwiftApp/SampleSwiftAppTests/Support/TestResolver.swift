//
//  TestResolver.swift
//  SampleSwiftAppTests
//
//  Created by am10 on 2020/06/27.
//  Copyright © 2020 am10. All rights reserved.
//

@testable import SampleSwiftApp
@testable import Models

final class TestResolver: AppResolver {
    private let database = DummyDatabase()

    func provideResolver() -> AppResolver {
        return self
    }

    func provideAPIClient() -> APIClient {
        return DummyAPIClient.shared
    }

    func provideDatabase() -> Database {
        return database
    }
}

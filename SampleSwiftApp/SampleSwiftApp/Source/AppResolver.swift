//
//  AppResolver.swift
//  SampleSwiftApp
//
//  Created by am10 on 2020/06/22.
//  Copyright © 2020 am10. All rights reserved.
//

import DIKit
import Models

protocol AppResolver: Resolver {
    func provideAPIClient() -> APIClient
    func provideResolver() -> AppResolver
    func provideDatabase() -> Database
}

final class AppResolverImpl: AppResolver {
    func provideResolver() -> AppResolver {
        return self
    }

    func provideAPIClient() -> APIClient {
        #if DUMMY
          return DummyAPIClient.shared
        #else
          return DefaultAPIClient.shared
        #endif
    }

    func provideDatabase() -> Database {
        return RealmDatabase()
    }
}

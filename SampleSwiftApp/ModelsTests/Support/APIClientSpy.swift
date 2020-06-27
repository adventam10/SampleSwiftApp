//
//  APIClientSpy.swift
//  ModelsTests
//
//  Created by am10 on 2020/06/27.
//  Copyright © 2020 am10. All rights reserved.
//

@testable import Models

final class APIClientSpy: APIClient {
    private(set) var sendPassedRequest: Request?
    private(set) var requestDecodablePassedRequest: Request?

    func send(_ request: Request, completion: @escaping (Result<Data, APIError>) -> Void) {
        sendPassedRequest = request
    }
    
    func requestDecodable<T>(_ request: Request, completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable {
        requestDecodablePassedRequest = request
    }
}

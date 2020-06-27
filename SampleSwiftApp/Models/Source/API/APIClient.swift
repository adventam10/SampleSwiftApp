//
//  APIClient.swift
//  Models
//
//  Created by am10 on 2020/06/27.
//  Copyright © 2020 am10. All rights reserved.
//

import Foundation
import class APIKit.URLEncodedSerialization

public enum APIError: Error {
    case network
    case server
    case invalidJSON
    case invalidData
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .network:
            return "ネットワークの接続状態を確認してください。"
        case .server:
            return "サーバーと通信できません。"
        case .invalidJSON:
            return "JSONパース失敗。"
        case .invalidData:
            return "データ不正"
        }
    }
}

public enum HTTPMethod: String {
    case post
    case get
}

public protocol Request {
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var headerFields: [String: String] { get }
    var parameter: [String: Any] { get }
    var timeout: TimeInterval { get }
    var contentType: String { get }
    var accept: String { get }
    
    func makeRequest() -> URLRequest
}

public extension Request {
    var headerFields: [String: String] {
        return [:]
    }

    var timeout: TimeInterval {
        return 65
    }

    var contentType: String {
        return ""
    }

    var accept: String {
        return ""
    }

    func makeRequest() -> URLRequest {
        let url = path.isEmpty ? baseURL : baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url, timeoutInterval: timeout)
        urlRequest.httpMethod = method.rawValue
        if !parameter.isEmpty {
            switch method {
            case .get:
                var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
                components.percentEncodedQuery = URLEncodedSerialization.string(from: parameter)
                urlRequest.url = components.url
            case .post:
                urlRequest.httpBody = try? URLEncodedSerialization.data(from: parameter, encoding: .utf8)
            }
        }
        headerFields.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        if case .post = method {
            if !contentType.isEmpty {
                urlRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
            }
        }
        if !accept.isEmpty {
            urlRequest.setValue(accept, forHTTPHeaderField: "Accept")
        }
        return urlRequest
    }
}

public protocol APIClient {
    func send(_ request: Request, completion: @escaping (Result<Data, APIError>) -> Void)
    func requestDecodable<T: Decodable>(_ request: Request, completion: @escaping (Result<T, APIError>) -> Void)
}

public final class DefaultAPIClient: APIClient {
    public static let shared = DefaultAPIClient()

    private init() {}

    public func send(_ request: Request, completion: @escaping (Result<Data, APIError>) -> Void) {
        let task = URLSession.shared.dataTask(with: request.makeRequest()) { (data, response, error) in
            if error != nil {
                completion(.failure(.network))
                return
            }
            if (response as? HTTPURLResponse)?.statusCode != 200 {
                completion(.failure(.server))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }

    public func requestDecodable<T>(_ request: Request, completion: @escaping (Result<T, APIError>) -> Void) where T: Decodable {
        send(request) { result in
            switch result {
            case .success(let data):
                if let result = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(result))
                } else {
                    completion(.failure(.invalidJSON))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

//
//  AvatarAPI.swift
//  Models
//
//  Created by am10 on 2020/06/27.
//  Copyright © 2020 am10. All rights reserved.
//

import Foundation

public class AvatarAPI {
    private let apiClient: APIClient

    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    public func getAvatar(avatarType: AvatarAPIRequest.AvatarType, completion: @escaping (Result<Data, APIError>) -> Void) {
        apiClient.send(AvatarAPIRequest.getAvatar(type: avatarType), completion: completion)
    }
}

public enum AvatarAPIRequest: Request {
    public enum AvatarType {
        case random
        case randomMale
        case randomFemale
        case named(name: String)
        case namedMale(name: String)
        case namedFemale(name: String)

        var seed: String {
            switch self {
            case .random:
                return "random"
            case .randomMale:
                return "male/random"
            case .randomFemale:
                return "female/random"
            case .named(let name):
                return name
            case .namedMale(let name):
                return "male/\(name)"
            case .namedFemale(let name):
                return "female/\(name)"
            }
        }
    }
    case getAvatar(type: AvatarType)

    public var baseURL: URL {
        #if DEBUG
          // デバッグ（必要であればここでURLを開発用途化に変える）*別モジュールなのでDUMMYは使えない
          return URL(string: "https://joeschmoe.io/api")!
        #else
          // 本番
          return URL(string: "https://joeschmoe.io/api")!
        #endif
    }

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        switch self {
        case .getAvatar(let type):
            return "v1/\(type.seed)"
        }
    }

    public var parameter: [String: Any] {
        return [:]
    }
}

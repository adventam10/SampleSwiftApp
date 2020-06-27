//
//  EqualAvatarAPIRequest.swift
//  ModelsTests
//
//  Created by am10 on 2020/06/27.
//  Copyright © 2020 am10. All rights reserved.
//

import Foundation
import Nimble

@testable import Models

func equal(_ expectedAvatarAPIRequest: AvatarAPIRequest) -> Predicate<AvatarAPIRequest> {
    return Predicate.define("equal <\(stringify(expectedAvatarAPIRequest))>") {
        actualExpression, message in
        guard let actualAvatarAPIRequest = try actualExpression.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }
        return PredicateResult(bool: actualAvatarAPIRequest == expectedAvatarAPIRequest, message: message)
    }
}

private func == (lhs: AvatarAPIRequest, rhs: AvatarAPIRequest) -> Bool {
    switch (lhs, rhs) {
    case (.getAvatar(let lType), .getAvatar(let rType)):
        switch (lType, rType) {
        case (.random, .random):
            return true
        case (.randomMale, .randomMale):
            return true
        case (.randomFemale, .randomFemale):
            return true
        case (.named(let lName), .named(let rName)):
            return lName == rName
        case (.namedMale(let lName), .namedMale(let rName)):
            return lName == rName
        case (.namedFemale(let lName), .namedFemale(let rName)):
            return lName == rName
        default:
            return false
        }
    }
}

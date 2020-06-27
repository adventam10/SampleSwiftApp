//
//  History.swift
//  Models
//
//  Created by am10 on 2020/06/27.
//  Copyright © 2020 am10. All rights reserved.
//

import Foundation
import RealmSwift

public final class History: Object {
    // swiftlint:disable:next identifier_name
    @objc public dynamic var id = NSUUID().uuidString
    @objc public dynamic var name: String = ""
    @objc public dynamic var weather: Data?

    override public static func primaryKey() -> String? {
        return "id"
    }

    override public static func indexedProperties() -> [String] {
        return ["id"]
    }
}

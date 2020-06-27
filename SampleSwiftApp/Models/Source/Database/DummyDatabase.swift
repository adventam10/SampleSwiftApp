//
//  DummyDatabase.swift
//  Models
//
//  Created by am10 on 2020/06/27.
//  Copyright © 2020 am10. All rights reserved.
//

import Foundation

public final class DummyDatabase: Database {
    private var data: [String: Any] = [:]

    public func fetchAll<T>(_ type: T.Type) -> [T] where T: Object {
        guard let target = data[type.description()] as? [T] else {
            return []
        }
        return target
    }

    public func removeAll<T>(_ type: T.Type) where T: Object {
        data[type.description()] = nil
    }

    public func add<T>(_ object: T) where T: Object {
        let key = T.self.description()
        guard var target = data[key] as? [T] else {
            data[key] = [object]
            return
        }
        target.append(object)
        data[key] = target
    }

    public func remove<T>(_ object: T) where T: Object {
        let key = T.self.description()
        guard var target = data[key] as? [T] else {
            return
        }
        if let index = target.firstIndex(where: { $0 == object }) {
            target.remove(at: index)
            data[key] = target
        }
    }

    public func update<T>(_ object: T) where T: Object {
        let key = T.self.description()
        guard var target = data[key] as? [T] else {
            return
        }
        let index = target.firstIndex { $0.value(forKey: "id") as? String == object.value(forKey: "id") as? String }
        if let index = index {
            target[index] = object
            data[key] = target
        }
    }
}

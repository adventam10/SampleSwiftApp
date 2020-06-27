//
//  Database.swift
//  Models
//
//  Created by am10 on 2020/06/27.
//  Copyright © 2020 am10. All rights reserved.
//

import Foundation
import RealmSwift

public typealias Object = RealmSwift.Object

public protocol Database {
    func fetchAll<T: Object>(_ type: T.Type) -> [T]
    func removeAll<T: Object>(_ type: T.Type)
    func add<T: Object>(_ object: T)
    func remove<T: Object>(_ object: T)
    func update<T: Object>(_ object: T)
}

public final class RealmDatabase: Database {
    private let realm = try! Realm()

    public init() {
    }

    private func realmWrite(_ block: @escaping ((Realm) -> Void)) {
        do {
            try realm.write {
                block(realm)
            }
        } catch {
            assertionFailure("Realm書き込み失敗")
        }
    }

    public func fetchAll<T>(_ type: T.Type) -> [T] where T: Object {
        return Array(realm.objects(type))
    }

    public func removeAll<T>(_ type: T.Type) where T: Object {
        realmWrite { realm in
            realm.delete(realm.objects(type))
        }
    }

    public func add<T>(_ object: T) where T: Object {
        realmWrite { realm in
            realm.add(object)
        }
    }

    public func remove<T>(_ object: T) where T: Object {
        realmWrite { realm in
            realm.delete(object)
        }
    }

    public func update<T>(_ object: T) where T: Object {
        realmWrite { realm in
            realm.add(object, update: .modified)
        }
    }
}

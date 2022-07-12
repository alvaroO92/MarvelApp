//
//  RealmManager.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 1/7/22.
//

import Foundation
import RealmSwift

protocol RealmManagerProtocol {
    func object<T: Object>(fromEntity entity : T.Type) -> Results<T>?
    func object<T: Object>(_ key: Any?) -> T?
    func object<T: Object>(_ predicate: (T) -> Bool) -> T?
    func objects<T: Object>() -> [T]
    func objects<T: Object>(_ predicate: (T) -> Bool) -> [T]

    @discardableResult func write<T: Object>(_ object: T?) -> Bool
    @discardableResult func write<T: Object>(_ objects: [T]?) -> Bool

    @discardableResult func update(_ block: () -> ()) -> Bool
    @discardableResult func delete<T: Object>(_ object: T) -> Bool
}

final class RealmManager: RealmManagerProtocol {

    var realm: Realm? {
        RealmConfig.shared.realm
    }

    func object<T: Object>(fromEntity entity : T.Type) -> Results<T>? {
        let object = self.realm?.objects(entity)
        return object
    }

    func object<T: Object>(_ key: Any?) -> T? {
        guard let key: Any = key else { return nil }
        guard let realm: Realm = self.realm else { return nil }
        guard let object: T = realm.object(ofType: T.self, forPrimaryKey: key) else { return nil }
        return !object.isInvalidated ? object : nil
    }

    func object<T: Object>(_ predicate: (T) -> Bool) -> T? {
        guard let realm: Realm = self.realm else { return nil }
        return realm.objects(T.self).filter(predicate).filter({ !$0.isInvalidated }).first
    }

    func objects<T: Object>() -> [T] {
        guard let realm: Realm = self.realm else { return [] }
        return realm.objects(T.self).filter({ !$0.isInvalidated })
    }

    func objects<T: Object>(_ predicate: (T) -> Bool) -> [T] {
        guard let realm: Realm = self.realm else { return [] }
        return realm.objects(T.self).filter(predicate).filter({ !$0.isInvalidated })
    }

    func write<T: Object>(_ object: T?) -> Bool {
        guard let object: T = object else { return false }
        guard let realm: Realm = self.realm else { return false }
        guard !object.isInvalidated else { return false }

        do {
            try realm.write { () -> Bool in
                realm.add(object, update: .all)
                return true
            }
            return false
        } catch let error {
            print("Writing failed for ", String(describing: T.self), " with error ", error)
        }
        return false
    }


    func write<T: Object>(_ objects: [T]?) -> Bool {
        guard let objects: [T] = objects else { return false }
        guard let realm: Realm = self.realm else { return false }
        let validated: [T] = objects.filter({ !$0.isInvalidated })
        do {
            try realm.write {
                realm.add(validated, update: .all)
            }
            return true
        } catch let error {
            print("Writing of array failed for ", String(describing: T.self), " with error ", error)
        }
        return false
    }

    func update(_ block: () -> ()) -> Bool {
        guard let realm: Realm = self.realm else { return false }
        do {
            try realm.write(block)
            return true
        } catch let error {
            print("Updating failed with error ", error)
        }
        return false
    }

    func delete<T: Object>(_ object: T) -> Bool {
        guard let realm: Realm = self.realm else { return false }
        guard !object.isInvalidated else { return true }
        do {
            try realm.write {
                realm.delete(object)
            }
            return true
        } catch let error {
            print("Writing of array failed for ", String(describing: T.self), " with error ", error)
        }
        return false
    }
}


//
//  LocalDatabaseFake.swift
//  MarvelAppTests
//
//  Created by Alvaro Orti Moreno on 3/7/22.
//

import XCTest
import RealmSwift
@testable import MarvelApp

final class LocalDatabaseFake: NSObject, RealmManagerProtocol {
    func object<T: Object>(fromEntity entity : T.Type) -> Results<T>? {
        nil
    }

    func object<T: Object>(_ key: Any?) -> T? {
        nil
    }

    func object<T: Object>(_ predicate: (T) -> Bool) -> T? {
        nil
    }

    func objects<T: Object>() -> [T] {
        []
    }

    func objects<T: Object>(_ predicate: (T) -> Bool) -> [T] { []
    }

    @discardableResult func write<T: Object>(_ object: T?) -> Bool {
        false
    }

    @discardableResult func write<T: Object>(_ objects: [T]?) -> Bool {
        false
    }

    @discardableResult func update(_ block: () -> ()) -> Bool {
        false
    }

    @discardableResult func delete<T: Object>(_ object: T) -> Bool {
        false
    }
}

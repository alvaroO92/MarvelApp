//
//  RealmConfig.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 1/7/22.
//

import Foundation
import RealmSwift

final class RealmConfig {
    static let shared = RealmConfig()

    public var realm: Realm?

    private init() {
        do {
            realm = try Realm(configuration: configuration)
        } catch let error {
            let nsError: NSError = error as NSError
            if nsError.code == 10 {
                guard let defaultPath: URL = Realm.Configuration.defaultConfiguration.fileURL else { return }
                try? FileManager.default.removeItem(at: defaultPath)
            }
            debugPrint("Default realm init failed: \(error)")
        }
    }

    private var configuration: Realm.Configuration {
        let config = Realm.Configuration(shouldCompactOnLaunch: { total, used in
            // compact if the file is over 70MB than 50% 'used'
            let maxMegaBytes = 70 * 1024 * 1024
            debugPrint("REALM STORAGE: \(used) - \(total)")
            return (total > maxMegaBytes) && (Double(used) / Double(total)) < 0.5
        })
        return config
    }
}


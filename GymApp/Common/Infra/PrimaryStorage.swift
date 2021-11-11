//
//  PrimaryStorage.swift
//  GymApp
//
//  Created by rafael.rollo on 11/11/21.
//

import Foundation

private struct UserDefaultInfo<T> {
    var key: String
    var defaultValue: T

    func get() -> T {
        guard let rawValue = UserDefaults.standard.object(forKey: self.key) else {
            return self.defaultValue
        }

        guard let value = rawValue as? T else {
            return self.defaultValue
        }

        return value
    }

    func set(_ value: T) {
        UserDefaults.standard.set(value, forKey: self.key)
    }
}

enum Storage {
    private static var walkthroughInfo = UserDefaultInfo(key: "completedWalkthrough", defaultValue: false)

    static var walkthroughHasAlreadyBeenSeen: Bool {
        get {
            return walkthroughInfo.get()
        }
        set {
            walkthroughInfo.set(newValue)
        }
    }
}
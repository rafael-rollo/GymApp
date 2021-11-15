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
    
    /**
     Walkthrought completion related info
     */
    private static var walkthroughInfo = UserDefaultInfo(key: "completedWalkthrough", defaultValue: false)

    static var walkthroughHasAlreadyBeenSeen: Bool {
        get {
            return walkthroughInfo.get()
        }
        set {
            walkthroughInfo.set(newValue)
        }
    }
    
    /**
     Location Permission screen related info
     */
    private static var locationPermissionRequestInfo = UserDefaultInfo(key: "locationPermissionRequested", defaultValue: false)

    static var locationPermissionHasAlreadyBeenRequested: Bool {
        get {
            return locationPermissionRequestInfo.get()
        }
        set {
            locationPermissionRequestInfo.set(newValue)
        }
    }
    
    /**
     User's log in related info
     */
    private static var usersAuthenticationToken = UserDefaultInfo<String?>(key: "authentication", defaultValue: nil)

    static var usersAuthentication: Authentication? {
        get {
            guard let usersAuthenticationToken = usersAuthenticationToken.get() else { return nil }
            return Authentication(token: usersAuthenticationToken)
        }
        set {
            guard let token = newValue?.token else {
                debugPrint("Couldn't save an invalid authentication token")
                return
            }

            usersAuthenticationToken.set(token)
        }
    }

    static var isUserLogged: Bool {
        get {
            return usersAuthenticationToken.get() != nil
        }
    }
    
}

//
//  Users.swift
//  GymApp
//
//  Created by rafael.rollo on 12/11/21.
//

import Foundation

class Users {

    func findUserAccount(by email: String,
                         completionHandler: @escaping (User) -> Void,
                         failureHandler: @escaping () -> Void) {

        let responseTime = 1.0 // seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + responseTime) {
            let user: User = .init(name: "Rafael Rollo", email: "rafael.rollo@zup.com.br")
            completionHandler(user)
        }
    }

}

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

        let responseTime = 2.0 // seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + responseTime) {
            let user: User = .init(name: "Rafael Rollo", email: "rafael.rollo@zup.com.br")
            completionHandler(user)
        }
    }
    
    func getAuthentication(from password: String,
                           completionHandler: @escaping (Authentication) -> Void,
                           failureHandler: @escaping () -> Void) {
        let responseTime = 2.5 // seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + responseTime) {
            let authentication: Authentication = .init(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjMiLCJuYW1lIjoiUmFmYWVsIFJvbGxvIiwiZW1haWwiOiJyYWZhZWwucm9sbG9AenVwLmNvbSIsImlhdCI6MTUxNjIzOTAyMn0.qh5oQSFog2_YtNRp5BlZCS-DmHl7BDp6D7dLr3YaEQo")
            completionHandler(authentication)
        }
    }

}

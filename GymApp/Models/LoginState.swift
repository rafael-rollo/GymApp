//
//  LoginState.swift
//  GymApp
//
//  Created by rafael.rollo on 12/11/21.
//

import Foundation

struct FormInfo {
    var title: String
    var description: String?
    var switchableAccount: Bool
    var emailFieldVisible: Bool
    var passwordFieldVisible: Bool
    var buttonTitle: String
}

enum LoginState {
    case undeterminedUser
    case identifiedAccount

    func formInfo() -> FormInfo {
        switch self {
        case .undeterminedUser:
            return .init(title: "Enter your email",
                         description: "It's the one you used to sign up for Gym.app.",
                         switchableAccount: false, emailFieldVisible: true,
                         passwordFieldVisible: false, buttonTitle: "Continue")

        case .identifiedAccount:
            return .init(title: "Now, your password",
                         description: nil, switchableAccount: true, emailFieldVisible: false,
                         passwordFieldVisible: true, buttonTitle: "Log in")
        }


    }
}

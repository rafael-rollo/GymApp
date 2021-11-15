//
//  ValidatedInput.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

protocol ValidatedInput: UIView {
    var rules: [Rule] { get set }

    func getText() -> String?
    func setErrorMessageHidden()
    func showError(_ message: String)
}

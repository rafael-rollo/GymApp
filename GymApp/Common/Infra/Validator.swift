//
//  Validator.swift
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

class Validator {

    private var targetInputViews: [ValidatedInput] = []
    private var validationErrorCount: Int = 0

    private func reset() {
        validationErrorCount = 0
    }

    private func validate(text: String, with ruls: [Rule]) -> String? {
        return ruls.compactMap({ $0.check(text) }).first
    }

    private func validate(_ input: ValidatedInput) {
        guard let message = validate(text: input.getText() ?? "", with: input.rules) else {
            input.setErrorMessageHidden()
            return
        }

        validationErrorCount += 1
        input.showError(message)
    }

    func requireValidation(on inputView: ValidatedInput) {
        targetInputViews.append(inputView)
    }

    func isFormValid() -> Bool {
        reset()

        targetInputViews.forEach { inputView in
            validate(inputView)
        }

        return validationErrorCount == 0
    }
}

enum Rule {
    case notEmpty
    case validEmail

    func check(_ text: String) -> String? {
        switch self {
        case .notEmpty:
            return text.isEmpty ? "Can not be empty" : nil


        case .validEmail:
            let regex = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#

            let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
            return predicate.evaluate(with: text) ? nil : "Enter a valid email address"
        }
    }
}

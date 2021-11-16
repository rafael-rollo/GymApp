//
//  Alert+UIViewController.swift
//  GymApp
//
//  Created by rafael.rollo on 11/11/21.
//

import UIKit

extension UIViewController {
    func showAlert(withTitle title: String?,
                   message: String?,
                   onDismiss: ((UIAlertAction) -> Void)? = nil) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let action = UIAlertAction(title: "OK", style: .cancel, handler: onDismiss)

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

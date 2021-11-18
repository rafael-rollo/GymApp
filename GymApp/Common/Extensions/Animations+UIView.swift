//
//  Animations+UIView.swift
//  GymApp
//
//  Created by rafael.rollo on 11/11/21.
//

import UIKit

extension UIView {

    func rotate(by radians: CGFloat) {
        UIView.animate(withDuration: 1) {
            self.transform = CGAffineTransform(rotationAngle: radians)
        }
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 0
            self.isUserInteractionEnabled = false
        }
    }

    func fadeIn() {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1
            self.isUserInteractionEnabled = true
        }
    }

}

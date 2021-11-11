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

}

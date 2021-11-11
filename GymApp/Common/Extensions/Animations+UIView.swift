//
//  Animations+UIView.swift
//  GymApp
//
//  Created by rafael.rollo on 11/11/21.
//

import UIKit

extension UIView {

    func rotate(by degrees: CGFloat) {
        UIView.animate(withDuration: 1) {
            let radians = CGFloat.angle(from: degrees)
            self.transform = CGAffineTransform(rotationAngle: radians)
        }
    }

}

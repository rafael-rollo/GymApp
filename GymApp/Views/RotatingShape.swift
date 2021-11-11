//
//  RotatingShape.swift
//  GymApp
//
//  Created by rafael.rollo on 11/11/21.
//

import UIKit

class RotatingShape: UIImageView {

    struct Angles {
        static var groundZero: CGFloat = .angle(from: -150)
        static var firstStep: CGFloat = .angle(from: -130)
        static var secondStep: CGFloat = .angle(from: -160)
        static var thirdStep: CGFloat = .angle(from: -190)
    }

    override init(image: UIImage? = UIImage(named: "AnimatedShape")) {
        super.init(image: image)
        transform = CGAffineTransform(rotationAngle: Angles.groundZero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

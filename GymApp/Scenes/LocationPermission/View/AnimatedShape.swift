//
//  AnimatedShape.swift
//  GymApp
//
//  Created by rafael.rollo on 11/11/21.
//

import UIKit

class AnimatedShape: UIImageView {

    private struct Angles {
        static var groundZero: CGFloat = .angle(from: -190)
        static var finalPosition: CGFloat = .angle(from: -245)
    }

    private var isCompactScreen: Bool {
        return UIScreen.main.bounds.width < 400
    }

    private var translationPoint: CGPoint {
        guard isCompactScreen else {
            return CGPoint(x: 96, y: 48)
        }
        return CGPoint(x: 76, y: 24)
    }

    private var scaleRatio: CGFloat {
        guard isCompactScreen else {
            return 1.6
        }
        return 1.4
    }

    override init(image: UIImage? = UIImage(named: "Shape")) {
        super.init(image: image)
        transform = CGAffineTransform(rotationAngle: Angles.groundZero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func animate() {
        UIView.animate(withDuration: 1) {
            let translate = CGAffineTransform(translationX: self.translationPoint.x,
                                              y: self.translationPoint.y)

            let rotate = CGAffineTransform(rotationAngle: Angles.finalPosition)
            let scale = CGAffineTransform(scaleX: self.scaleRatio, y: self.scaleRatio)

            self.transform = scale
                    .concatenating(rotate)
                    .concatenating(translate)
        }
    }
}

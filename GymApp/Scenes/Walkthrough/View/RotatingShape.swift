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

    func rotate(byInterpolating xOffset: CGFloat, maxOffset: CGFloat) {
        let px = interpolatingPolynomial(from: [.zero, maxOffset],
                                         to: [Angles.firstStep, Angles.secondStep])
        let angle = px(xOffset)

        UIView.animate(withDuration: .zero) { [weak self] in
            self?.transform = CGAffineTransform(rotationAngle: angle)
        }
    }

    fileprivate func interpolatingPolynomial(from x: [CGFloat],
                                             to fx: [CGFloat]) -> ((CGFloat) -> CGFloat) {
        // f[x1,x0]
        let fx1x0 = differenceOf(fx) / differenceOf(x)

        // p(offset) = f[x0] + f[x1,x0](x - x0)
        return { offset in
            return fx[0] + fx1x0 * (offset - x[0])
        }
    }

    fileprivate func differenceOf(_ table: [CGFloat]) -> CGFloat {
        return table.reversed().reduce(CGFloat.zero) { accumulated, current in
            guard accumulated != CGFloat.zero else { return current }
            return accumulated - current
        }
    }
}

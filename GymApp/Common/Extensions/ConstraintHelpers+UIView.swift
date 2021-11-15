//
//  ConstraintHelpers+UIView.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

extension UIView {

    var safeTopAnchor: NSLayoutYAxisAnchor {
        return safeAreaLayoutGuide.topAnchor
    }

    var safeLeadingAnchor: NSLayoutXAxisAnchor {
        return safeAreaLayoutGuide.leadingAnchor
    }

    var safeTrailingAnchor: NSLayoutXAxisAnchor {
        return safeAreaLayoutGuide.trailingAnchor
    }

    var safeBottomAnchor: NSLayoutYAxisAnchor {
        return safeAreaLayoutGuide.bottomAnchor
    }

    func constrainTo(boundsOf view: UIView) {
        let constraints = [
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    func constrainTo(safeBoundsOf view: UIView) {
        let constraints = [
            self.topAnchor.constraint(equalTo: view.safeTopAnchor),
            self.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor),
            self.bottomAnchor.constraint(equalTo: view.safeBottomAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    func constrainHeight(to constant: CGFloat) {
        let heightConstraint = [
            self.heightAnchor.constraint(equalToConstant: constant)
        ]

        NSLayoutConstraint.activate(heightConstraint)
    }

    func constrainToCenter(of view: UIView) {
        let constraints = [
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

}

//
//  ConstraintHelpers+UIView.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

extension UIView {

    // MARK: - safe anchors
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

    // MARK: - containing helpers
    func constrainTo(edgesOf view: UIView,
                     withHorizontalMarginsOf horizontalMargin: CGFloat = 0) {
        let constraints = [
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    func constrainTo(safeEdgesOf view: UIView) {
        let constraints = [
            self.topAnchor.constraint(equalTo: view.safeTopAnchor),
            self.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor),
            self.bottomAnchor.constraint(equalTo: view.safeBottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

    func constrainToTop(of view: UIView, with margin: CGFloat = 0, safely: Bool = false) {
        let topAnchor = safely ? view.safeTopAnchor : view.topAnchor
        self.topAnchor.constraint(equalTo: topAnchor, constant: margin).isActive = true
    }

    func constrainToTopLeading(of view: UIView,
                               top topMargin: CGFloat = 0,
                               leading leadingMargin: CGFloat = 0) {
        let constraints = [
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingMargin),
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: topMargin)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    func constrainToTopAndSides(of view: UIView) {
        let constraints = [
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    func constrainToLeading(of view: UIView, with margin: CGFloat = 0) {
        let constraints = [
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    func constrainToBottom(of view: UIView, with margin: CGFloat = 0, safely: Bool = false) {
        let bottomAnchor = safely ? view.safeBottomAnchor : view.bottomAnchor
        self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin).isActive = true
    }

    func constrainToBottomAndSides(of view: UIView,
                                   bottom: CGFloat = 0,
                                   horizontalMargins: CGFloat = 0) {
        let constraints = [
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottom),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargins),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargins)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    func constrainHorizontallyTo(_ view: UIView, withMarginsOf horizontalMargins: CGFloat = 0) {
        let constraints = [
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargins),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargins),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    func constrainToCenter(of view: UIView) {
        let constraints = [
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - positioning helpers
    func anchorAbove(_ view: UIView, withMarginOf margin: CGFloat) {
        let constraints = [
            self.bottomAnchor.constraint(equalTo: view.topAnchor, constant: -margin),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - sizing helpers
    func constrainWidth(to constant: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
    }

    func constrainHeight(to constant: CGFloat) {
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
    }

}

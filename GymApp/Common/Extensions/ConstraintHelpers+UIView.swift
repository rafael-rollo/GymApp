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

    @discardableResult
    func constrainToTop(of view: UIView,
                        with margin: CGFloat = 0,
                        notchSafe: Bool = false) -> NSLayoutConstraint {

        let topAnchor = notchSafe ? view.safeTopAnchor : view.topAnchor
        let constraint = self.topAnchor.constraint(equalTo: topAnchor, constant: margin)

        NSLayoutConstraint.activate([constraint])
        return constraint
    }

    func constrainToTopLeading(of view: UIView,
                               top topMargin: CGFloat = 0,
                               leading leadingMargin: CGFloat = 0,
                               notchSafe: Bool = false) {
        let topAnchor = notchSafe ? view.safeTopAnchor : view.topAnchor

        let constraints = [
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingMargin),
            self.topAnchor.constraint(equalTo: topAnchor, constant: topMargin)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    func constrainToTopAndSides(of view: UIView,
                                top: CGFloat = 0,
                                horizontalMargins: CGFloat = 0,
                                notchSafe: Bool = false) {
        let topAnchor = notchSafe ? view.safeTopAnchor : view.topAnchor

        let constraints = [
            self.topAnchor.constraint(equalTo: topAnchor, constant: top),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargins),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargins)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    @discardableResult
    func constrainToLeading(of view: UIView, with margin: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = self.leadingAnchor
            .constraint(equalTo: view.leadingAnchor, constant: margin)

        NSLayoutConstraint.activate([constraint])
        return constraint
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
    
    // MARK: - positioning helpers
    func anchorAbove(_ view: UIView, withMarginOf margin: CGFloat) {
        self.bottomAnchor.constraint(equalTo: view.topAnchor, constant: -margin).isActive = true
    }
    
    func anchorBelow(_ view: UIView, withMarginOf margin: CGFloat) {
        self.topAnchor.constraint(equalTo: view.bottomAnchor, constant: margin).isActive = true
    }
    
    func anchorToCenter(of view: UIView, x: CGFloat = 0, y: CGFloat = 0) {
        let constraints = [
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: x),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: y)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - sizing helpers
    func constrainSizeTo(_ size: CGSize) {
        let constraints = [
            self.widthAnchor.constraint(equalToConstant: size.width),
            self.heightAnchor.constraint(equalToConstant: size.height)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    @discardableResult
    func constrainWidth(to constant: CGFloat) -> NSLayoutConstraint {
        let constraint = self.widthAnchor.constraint(equalToConstant: constant)
        constraint.isActive = true
        return constraint
    }

    func constrainHeight(to constant: CGFloat) {
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    @discardableResult
    func constrainHeight(greaterThanOrEqualTo constant: CGFloat) -> NSLayoutConstraint {
        let constraint = self.heightAnchor.constraint(greaterThanOrEqualToConstant: constant)
        constraint.isActive = true
        return constraint
    }

}

//
//  ExpandableHeader.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

class ExpandableHeader: UIView {

    // MARK: - properties
    override var bounds: CGRect {
        didSet {
            dropShadow()
        }
    }

    var heightConstraint: NSLayoutConstraint?

    var height: CGFloat { return 120 }
    var radius: CGFloat { return 12 }

    var isExpanded: Bool = false

    // MARK: - view lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()

        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        addGestureRecognizer(gesture)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        animatedShadowPath()
    }

    // MARK: - methods
    private func dropShadow() {
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.secondaryLabel.cgColor
        layer.shadowOffset = .init(width: 0, height: 5)
    }

    private func animatedShadowPath() {
        let currentPath = layer.shadowPath
        let newPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath

        guard let heightAnimation = layer.animation(forKey: "bounds.size")
                as? CABasicAnimation else {
            layer.shadowPath = newPath
            return
        }

        let pathAnimation = CABasicAnimation(keyPath: "shadowPath")
        pathAnimation.duration = heightAnimation.duration
        pathAnimation.timingFunction = heightAnimation.timingFunction
        pathAnimation.fromValue = currentPath
        pathAnimation.toValue = newPath

        layer.add(pathAnimation, forKey: "shadowPath")
        layer.shadowPath = newPath
    }

    @objc private func viewTapped(_ sender: UIView) {
        guard let superview = superview else {
            return
        }

        let updatedHeightValue = isExpanded ? height : superview.bounds.height
        heightConstraint?.constant = updatedHeightValue

        UIView.animate(withDuration: 0.5) {
            superview.layoutIfNeeded()
        }

        isExpanded = !isExpanded
    }
}

// MARK: - view code
extension ExpandableHeader: ViewCode {
    func addConstraints() {
        heightConstraint = constrainHeight(to: height)
    }

    func addTheme() {
        backgroundColor = .white

        layer.masksToBounds = false
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
}

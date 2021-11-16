//
//  WellnessApps.swift
//  GymApp
//
//  Created by rafael.rollo on 16/11/21.
//

import UIKit

class WellnessApps: UIView {

    fileprivate struct LayoutProps {
        static let height: CGFloat = 180
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WellnessApps: ViewCode {
    func addViews() {

    }

    func addConstraints() {
        self.constrainHeight(to: LayoutProps.height)
    }

    func addTheme() {
        backgroundColor = .terracotta?.withAlphaComponent(0.1)
    }
}

//
//  WellnessApps.swift
//  GymApp
//
//  Created by rafael.rollo on 16/11/21.
//

import UIKit
import Lottie

class WellnessApps: UIView {

    fileprivate struct LayoutProps {
        static let height: CGFloat = 180
    }
    
    // MARK: - subviews
    private lazy var skeletonAnimationView: AnimationView = {
        let animation = AnimationView(name: "BannerSkeleton")
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.contentMode = .scaleToFill
        animation.loopMode = .loop
        animation.animationSpeed = 1.5
        animation.play()
        return animation
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WellnessApps: ViewCode {
    
    func addTheme() {
        backgroundColor = .clear
    }
    
    func addViews() {
        self.addSubview(skeletonAnimationView)
    }

    func addConstraints() {
        self.constrainHeight(to: LayoutProps.height)
        skeletonAnimationView.constrainTo(edgesOf: self)
    }

}

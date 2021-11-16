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
        static let height: CGFloat = 240
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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(.bold, size: 14)
        label.textColor = .shipGray
        label.text = "Apps included in your plan"
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(size: 12)
        label.textColor = .shipGray
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.text = "Enjoy premium access to our digital partners to take care of your body, mind, and mood"
        return label
    }()
    
    private lazy var titlesView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel,
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 92)
        view.spacing = 16
        return view
    }()

    private lazy var appList: AppList = {
        let list = AppList()
        list.translatesAutoresizingMaskIntoConstraints = false
        return list
    }()

    private lazy var containerView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            titlesView,
            appList,
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.backgroundColor = .terracotta?.withAlphaComponent(0.2)
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 32, left: 0, bottom: 32, right: 0)
        view.spacing = 16
        return view
    }()

    var apps: [WellnessAppData]? {
        didSet {
            if let apps = apps {
                self.load(apps)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func load(_ apps: [WellnessAppData]) {
        appList.apps = apps

        transitionAnimating()
    }

    private func transitionAnimating() {
        let transition: (() -> Void)? = { [weak self] in
            guard let self = self else { return }

            self.skeletonAnimationView.removeFromSuperview()

            self.addSubview(self.containerView)
            self.containerView.constrainTo(edgesOf: self)
        }

        UIView.transition(
            with: self,
            duration: 0.5,
            options: .transitionCrossDissolve,
            animations: transition,
            completion: nil
        )
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

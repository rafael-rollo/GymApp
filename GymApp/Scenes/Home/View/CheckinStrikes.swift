//
//  CheckinStrikes.swift
//  GymApp
//
//  Created by rafael.rollo on 16/11/21.
//

import UIKit
import Lottie

class CheckinStrikes: UIView {

    private lazy var sectionTitle: SectionTitle = {
        let title = SectionTitle()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    private lazy var skeletonView: UIView = {
        let skeleton = AnimationView(name: "PillsSkeleton")
        skeleton.translatesAutoresizingMaskIntoConstraints = false
        skeleton.contentMode = .scaleAspectFit
        skeleton.loopMode = .loop
        skeleton.animationSpeed = 1.5
        skeleton.play()

        let wrapper = UIView()
        wrapper.translatesAutoresizingMaskIntoConstraints = false
        wrapper.addSubview(skeleton)

        skeleton.constrainTo(edgesOf: wrapper, horizontalMargins: 24)
        return wrapper
    }()

    private lazy var containerView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            sectionTitle,
            skeletonView
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CheckinStrikes: ViewCode {
    func addViews() {
        addSubview(containerView)
    }

    func addConstraints() {
        self.constrainHeight(to: 200)
        containerView.constrainTo(edgesOf: self)
    }
}

//
//  CheckinStrikes.swift
//  GymApp
//
//  Created by rafael.rollo on 16/11/21.
//

import UIKit
import Lottie

class UserStrikes: UIView {

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
    
    var strikes: [StrikeData]? {
        didSet {
            if let strikes = strikes {
                self.load(strikes)
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
    
    private func load(_ strikes: [StrikeData]) {
        let animateUpdate: (() -> Void)? = { [weak self] in
            self?.sectionTitle.text = "Your strikes"
        }

        UIView.transition(with: self,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: animateUpdate,
                          completion: nil)
    }

}

extension UserStrikes: ViewCode {
    func addViews() {
        addSubview(containerView)
    }

    func addConstraints() {
        self.constrainHeight(to: 200)
        containerView.constrainTo(edgesOf: self)
    }
}

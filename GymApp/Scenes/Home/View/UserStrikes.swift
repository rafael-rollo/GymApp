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

    private lazy var characterImageView: UIImageView = {
        let image = UIImage(named: "ElevatedRunningCharacter")

        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    private lazy var strikesStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 32
        return stack
    }()

    private lazy var strikesView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
        scrollView.addSubview(strikesStackView)
        return scrollView
    }()

    private lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.white.cgColor,
                        UIColor.white.withAlphaComponent(0.0).cgColor]
        layer.frame = CGRect(x: 0, y: 0, width: 24, height: 124)
        layer.startPoint = CGPoint(x: 0.0, y: 0.5)
        layer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return layer
    }()

    private lazy var strikesViewWrapper: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(strikesView)

        view.layer.insertSublayer(gradientLayer, above: strikesView.layer)
        return view
    }()

    private lazy var contentView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            characterImageView, strikesViewWrapper
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .bottom
        return stack
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
        strikes.forEach { strikeData in
            let strike = Strike()
            strike.setup(from: strikeData)

            strikesStackView.addArrangedSubview(strike)
        }

        transitionAnimating()
    }

    private func transitionAnimating() {
        let transition: (() -> Void)? = { [weak self] in
            guard let self = self else { return }

            self.sectionTitle.text = "Your strikes"

            self.skeletonView.removeFromSuperview()
            self.containerView.addArrangedSubview(self.contentView)
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

extension UserStrikes: ViewCode {
    func addViews() {
        addSubview(containerView)
    }

    func addConstraints() {
        self.constrainHeight(to: 226)
        containerView.constrainTo(edgesOf: self)

        characterImageView.constrainHeight(to: 124)
        strikesView.constrainHeight(to: 124)

        strikesStackView.constrainTo(edgesOf: strikesView)
        strikesView.constrainTo(edgesOf: strikesViewWrapper)
    }
}

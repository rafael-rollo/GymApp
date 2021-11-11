//
//  NextButton.swift
//  GymApp
//
//  Created by rafael.rollo on 11/11/21.
//

import UIKit

class NextButton: UIButton {

    private lazy var image = UIImage(systemName: "arrow.forward")?
        .withRenderingMode(.alwaysTemplate)

    private var widthConstraint: NSLayoutConstraint?
    private let size = CGSize(width: 48, height: 48)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func animate(by pageIndex: Int) {
        let goingToLastPage = pageIndex == 2
        goingToLastPage ? inflate() : deflate()
    }

    private func inflate() {
        widthConstraint?.constant = size.width * 3

        UIView.transition(with: self,
                          duration: 0.5,
                          options: .showHideTransitionViews) { [weak self] in
            self?.superview!.layoutIfNeeded()

            self?.setImage(nil, for: .normal)
            self?.setTitle("Get started!", for: .normal)
        }
    }

    private func deflate() {
        widthConstraint?.constant = size.width

        UIView.transition(with: self,
                          duration: 0.5,
                          options: .showHideTransitionViews) { [weak self] in
            self?.superview!.layoutIfNeeded()

            self?.setImage(self?.image, for: .normal)
            self?.setTitle(nil, for: .normal)
        }
    }
}

extension NextButton: ViewCode {
    func addTheme() {
        backgroundColor = UIColor(named: "Terracotta")
        tintColor = .white
        layer.cornerRadius = size.height / 2
        layer.masksToBounds = true
        setImage(image, for: .normal)
    }

    func addConstraints() {
        widthConstraint = widthAnchor.constraint(equalToConstant: size.width)

        NSLayoutConstraint.activate([
            widthConstraint!,
            heightAnchor.constraint(equalToConstant: size.height)
        ])
    }
}

//
//  BannerCarousel.swift
//  GymApp
//
//  Created by rafael.rollo on 16/11/21.
//

import UIKit

class BannerCarousel: UIView {

    private lazy var firstView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blueViolet?.withAlphaComponent(0.3)
        return view
    }()

    private lazy var secondView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .terracotta?.withAlphaComponent(0.3)
        return view
    }()

    private lazy var thirdView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .shipGray?.withAlphaComponent(0.3)
        return view
    }()

    private lazy var contentContainer: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            firstView, secondView, thirdView
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.addSubview(contentContainer)
        return scrollView
    }()

    private lazy var carousel: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            scrollView
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

extension BannerCarousel: ViewCode {
    
    func addTheme() {
        backgroundColor = .white
    }
    
    func addViews() {
        addSubview(carousel)
    }

    func addConstraints() {
        self.constrainHeight(to: 260)
        carousel.constrainTo(edgesOf: self)

        contentContainer.constrainTo(edgesOf: scrollView)
        NSLayoutConstraint.activate([
            contentContainer.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentContainer.widthAnchor.constraint(
                equalTo: scrollView.widthAnchor,
                multiplier: 3
            )
        ])
    }

}

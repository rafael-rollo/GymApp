//
//  Carousel.swift
//  GymApp
//
//  Created by rafael.rollo on 11/11/21.
//

import UIKit

class Carousel: UIScrollView {

    private lazy var firstPage: Page = {
        let page = Page()
        page.translatesAutoresizingMaskIntoConstraints = false
        page.image = UIImage(named: "StretchingCharacter")
        page.title = "Find an activity to love"
        page.subtitle = "Try yoga, crossfit or anything in between. The choice is yours."
        return page
    }()

    private lazy var secondPage: Page = {
        let page = Page()
        page.translatesAutoresizingMaskIntoConstraints = false
        page.image = UIImage(named: "PilatesCharacter")
        page.title = "Workout close to home or work"
        page.subtitle = "Discover Gym.app wherever you are."
        return page
    }()

    private lazy var thirdPage: Page = {
        let page = Page()
        page.translatesAutoresizingMaskIntoConstraints = false
        page.image = UIImage(named: "RunningCharacter")
        page.title = "Hundreds of activities for one monthly membership"
        page.subtitle = "With no contracts or membership fees. Enjoy the flexibility."
        return page
    }()

    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            firstPage, secondPage, thirdPage
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func snapToPage(_ page: Int) {
        let point = CGPoint(x: CGFloat(page) * bounds.width, y: 0)
        setContentOffset(point, animated: true)
    }
}

extension Carousel: ViewCode {
    
    func addTheme() {
        isPagingEnabled = true
        showsHorizontalScrollIndicator = false
        layer.masksToBounds = false
    }
    
    func addViews() {
        addSubview(contentStackView)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.heightAnchor.constraint(equalTo: heightAnchor),
            contentStackView.widthAnchor.constraint(equalTo: widthAnchor,
                                                    multiplier: 3)
        ])
    }

}

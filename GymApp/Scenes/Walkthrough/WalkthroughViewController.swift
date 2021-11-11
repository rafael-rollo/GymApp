//
//  WalkthroughViewController.swift
//  GymApp
//
//  Created by rafael.rollo on 11/11/21.
//

import UIKit

class WalkthroughViewController: UIViewController {

    // MARK: - subviews
    private lazy var upperShape: RotatingShape = {
        let shape = RotatingShape()
        shape.translatesAutoresizingMaskIntoConstraints = false
        return shape
    }()
    
    private lazy var logo: UIImageView = {
        let logo = UIImage(named: "GymAppLogo")?.withTintColor(.white)
        let imageView = UIImageView(image: logo)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var skipButton: UIButton = {
        let atributedTitle = NSAttributedString(string: "Skip", attributes: [
            .foregroundColor: UIColor(named: "Relax") ?? .purple,
            .font: UIFont.openSans(.bold, size: UIFont.smallSystemFontSize)
        ])

        let button = UIButton()
        button.setAttributedTitle(atributedTitle, for: .normal)
        return button
    }()

    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            logo,
            skipButton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
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
        page.subtitle = "Discover Gympass wherever you are."
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

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.layer.masksToBounds = false
        scrollView.addSubview(contentStackView)
        return scrollView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let terracotta = UIColor(named: "Terracotta")

        let pageControll = UIPageControl()
        pageControll.translatesAutoresizingMaskIntoConstraints = false
        pageControll.numberOfPages = 3
        pageControll.currentPageIndicatorTintColor = terracotta
        pageControll.pageIndicatorTintColor = terracotta?.withAlphaComponent(0.5)
        return pageControll
    }()

    private lazy var nextButton: UIButton = {
        let image = UIImage(systemName: "arrow.forward")?
            .withRenderingMode(.alwaysTemplate)

        let button = UIButton()
        button.backgroundColor = UIColor(named: "Terracotta")
        button.tintColor = .white
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 24
        button.layer.masksToBounds = true
        return button
    }()

    private lazy var footerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            pageControl,
            nextButton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()

    // MARK: - view lifecycle
    override func loadView() {
        super.loadView()
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        upperShape.rotate(by: RotatingShape.Angles.firstStep)
    }
}

// MARK: - view code
extension WalkthroughViewController: ViewCode {
    
    func addTheme() {
        view.backgroundColor = .white
    }
    
    func addViews() {
        view.addSubview(upperShape)
        view.addSubview(titleStackView)
        view.addSubview(scrollView)
        view.addSubview(footerStackView)
    }

    func addConstraints() {
        let upperShapeXOffset = upperShape.bounds.width * 0.37
        let upperShapeYOffset = upperShape.bounds.height - view.bounds.height * 0.3
        
        NSLayoutConstraint.activate([
            upperShape.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -upperShapeXOffset),
            upperShape.topAnchor.constraint(equalTo: view.topAnchor, constant: -upperShapeYOffset)
        ])
        
        NSLayoutConstraint.activate([
            logo.widthAnchor.constraint(equalToConstant: 120),
        ])
        
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            titleStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 3)
        ])

        NSLayoutConstraint.activate([
            scrollView.bottomAnchor.constraint(equalTo: footerStackView.topAnchor, constant: -48),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
        
        // sorry! Apple doesn't help to do it better 😢
        NSLayoutConstraint.activate([
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            nextButton.widthAnchor.constraint(equalToConstant: 48),
            nextButton.heightAnchor.constraint(equalToConstant: 48)
        ])

        NSLayoutConstraint.activate([
            footerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
            footerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            footerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }

}

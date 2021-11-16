//
//  BannerCarousel.swift
//  GymApp
//
//  Created by rafael.rollo on 16/11/21.
//

import UIKit

class BannerCarousel: UIView {
    
    private lazy var bannerTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(.bold, size: 16)
        label.textColor = .shipGray
        label.text = "Personal training"
        return label
    }()

    private lazy var bannerDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = .openSans(size: 14)
        label.textColor = .shipGray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Discover dedicated support to ensure you reach your goals."
        return label
    }()

    private lazy var callToActionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(.extrabold, size: 14)
        label.textColor = .elm
        label.text = "Get started"
        return label
    }()

    private lazy var infoView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [ UIView(),
            bannerTitleLabel,
            bannerDescriptionLabel,
            callToActionLabel
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 24, left: 24, bottom: 24, right: 24)
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 12
        return stack
    }()

    private lazy var textureImageView: UIImageView = {
        let image = UIImage(named: "GreenStarsTexture")

        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .skeptic
        view.addSubview(textureImageView)
        view.addSubview(infoView)
        return view
    }()

    private lazy var characterImageView: UIImageView = {
        let image = UIImage(named: "TrainerCharacter")

        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var firstPage: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
        view.addSubview(characterImageView)
        return view
    }()

    private lazy var contentContainer: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            firstPage,
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
    
    private lazy var pageControl: UIPageControl = {
        let pageControll = UIPageControl()
        pageControll.translatesAutoresizingMaskIntoConstraints = false
        pageControll.numberOfPages = 3
        pageControll.pageIndicatorTintColor = .blueViolet?.withAlphaComponent(0.5)
        pageControll.currentPageIndicatorTintColor = .blueViolet
        return pageControll
    }()

    private lazy var carousel: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            scrollView, pageControl
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
        self.constrainHeight(to: 250)
        carousel.constrainTo(edgesOf: self)

        contentContainer.constrainTo(edgesOf: scrollView)
        NSLayoutConstraint.activate([
            contentContainer.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentContainer.widthAnchor.constraint(
                equalTo: scrollView.widthAnchor,
                multiplier: 1
            )
        ])
        
        backgroundView.constrainToTopAndSides(of: firstPage)
        backgroundView.heightAnchor.constraint(equalTo: firstPage.heightAnchor, multiplier: 0.9).isActive = true

        textureImageView.constrainVertically(to: backgroundView)
        textureImageView.constrainToTrailing(of: backgroundView)

        characterImageView.constrainToBottomAndTrailing(of: firstPage)

        infoView.constrainVertically(to: backgroundView)
        infoView.constrainToLeading(of: backgroundView)
        infoView.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.7).isActive = true
    }

}

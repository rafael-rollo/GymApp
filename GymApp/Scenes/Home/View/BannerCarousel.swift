//
//  BannerCarousel.swift
//  GymApp
//
//  Created by rafael.rollo on 16/11/21.
//

import UIKit

class BannerCarousel: UIView {
    
    // MARK: - subviews
    private lazy var contentContainer: UIStackView = {
        let stackView = UIStackView()
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
        pageControll.numberOfPages = 0
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

    // MARK: - attributes
    var banners: [BannerData]? {
        didSet {
            if let banners = banners {
                self.load(banners)
            }
        }
    }

    private var contentContainerWidthConstraint: NSLayoutConstraint?

    // MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - view methods
    private func load(_ banners: [BannerData]) {
        banners.forEach { bannerInfo in
            let banner = Banner()
            banner.setup(from: bannerInfo)
            contentContainer.addArrangedSubview(banner)
        }

        pageControl.numberOfPages = banners.count
        resizeContentContainer(for: banners.count)
    }

    private func resizeContentContainer(for numberOfPages: Int) {
        contentContainerWidthConstraint?.isActive = false
        contentContainer.constrainWidth(referencedBy: scrollView,
                                        withRatio: CGFloat(numberOfPages))

        contentContainer.alpha = 0
        layoutIfNeeded()

        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.contentContainer.alpha = 1
        }
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
        contentContainer.constrainHeight(referencedBy: scrollView)

        contentContainerWidthConstraint = contentContainer
            .constrainWidth(referencedBy: scrollView)
    }

}

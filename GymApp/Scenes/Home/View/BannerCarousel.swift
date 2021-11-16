//
//  BannerCarousel.swift
//  GymApp
//
//  Created by rafael.rollo on 16/11/21.
//

import UIKit
import Lottie

protocol BannerCarouselDelegate: AnyObject {
    func bannerCarouselDelegate(_ carousel: BannerCarousel,
                                didTapBanner data: BannerData)
}

class BannerCarousel: UIView {
    
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
    
    private lazy var contentContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.addArrangedSubview(skeletonAnimationView)
        return stackView
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
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
    
    weak var delegate: BannerCarouselDelegate?

    // MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
        pageControl.addTarget(self,
                              action: #selector(pageControlValueChanged(_:)),
                              for: .valueChanged)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - view methods
    @objc private func pageControlValueChanged(_ sender: UIPageControl) {
        self.snapToPage(sender.currentPage)
    }

    private func snapToPage(_ page: Int) {
        let point = CGPoint(x: CGFloat(page) * scrollView.bounds.width, y: 0)
        scrollView.setContentOffset(point, animated: true)
    }
    
    private func load(_ banners: [BannerData]) {
        skeletonAnimationView.removeFromSuperview()
        
        banners.forEach { bannerData in
            let banner = Banner()
            banner.setup(from: bannerData)
            banner.onTap = { [weak self] in
                guard let self = self else { return }
                self.delegate?.bannerCarouselDelegate(self, didTapBanner: bannerData)
            }

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

extension BannerCarousel: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollOffset = scrollView.contentOffset.x
        let currentPage = Int(scrollOffset / scrollView.bounds.width)

        pageControl.currentPage = currentPage
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

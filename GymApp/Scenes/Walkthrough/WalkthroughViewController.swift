//
//  WalkthroughViewController.swift
//  GymApp
//
//  Created by rafael.rollo on 11/11/21.
//

import UIKit

protocol WalkthroughViewControllerDelegate: AnyObject {
    func walkthroughViewControllerDidComplete(_ viewController: WalkthroughViewController)
}

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
            .foregroundColor: UIColor.blueViolet ?? .purple,
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
    
    private lazy var carousel: Carousel = {
        let carousel = Carousel()
        carousel.translatesAutoresizingMaskIntoConstraints = false
        carousel.delegate = self
        return carousel
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

    private lazy var nextButton: NextButton = {
        let button = NextButton()
        button.translatesAutoresizingMaskIntoConstraints = false
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
    
    // MARK: - properties
    
    private var currentPage: Int = 0
    
    weak var delegate: WalkthroughViewControllerDelegate?

    // MARK: - view lifecycle
    init(delegate: WalkthroughViewControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        upperShape.rotate(by: RotatingShape.Angles.firstStep)
        
        skipButton.addTarget(self,
                             action: #selector(completeWalkthrough),
                             for: .touchUpInside)
        
        pageControl.addTarget(self,
                              action: #selector(pageControlValueChanged(_:)),
                              for: .valueChanged)
        
        nextButton.addTarget(self,
                             action: #selector(nextButtonClicked(_:)),
                             for: .touchUpInside)
    }
    
    // MARK: - view methods
    @objc private func pageControlValueChanged(_ sender: UIPageControl) {
        self.currentPage = sender.currentPage
        carousel.snapToPage(self.currentPage)
    }
    
    @objc private func nextButtonClicked(_ sender: UIButton) {
        guard currentPage < 2 else {
            completeWalkthrough()
            return
        }

        currentPage += 1
        carousel.snapToPage(currentPage)
    }
    
    private func animateViews(carouselScrollOffset scrollOffset: CGFloat) {
        currentPage == 2 ? skipButton.fadeOut() : skipButton.fadeIn()

        upperShape.rotate(byInterpolating: scrollOffset,
                          maxOffset: carousel.bounds.width)

        nextButton.animate(by: currentPage)
    }

    @objc private func completeWalkthrough() {
        Storage.walkthroughHasAlreadyBeenSeen = true
        delegate?.walkthroughViewControllerDidComplete(self)
    }
    
}

// MARK: - Carousel delegate
extension WalkthroughViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollOffset = scrollView.contentOffset.x

        self.currentPage = Int(scrollOffset / scrollView.bounds.width)
        pageControl.currentPage = self.currentPage

        animateViews(carouselScrollOffset: scrollOffset)
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
        view.addSubview(carousel)
        view.addSubview(footerStackView)
    }

    func addConstraints() {
        let upperShapeXOffset = upperShape.bounds.width * 0.37
        let upperShapeYOffset = upperShape.bounds.height - view.bounds.height * 0.3
        
        upperShape.constrainToTopLeading(of: view,
                                         top: -upperShapeYOffset,
                                         leading: -upperShapeXOffset)
        
        logo.constrainWidth(to: 120)
        
        titleStackView.constrainHorizontallyTo(view, withMarginsOf: 24)
        titleStackView.constrainToTop(of: view, with: 48, safely: true)
        
        carousel.constrainHorizontallyTo(view)
        carousel.constrainHeight(to: view.bounds.height * 0.4)
        carousel.anchorAbove(footerStackView, withMarginOf: 48)

        footerStackView.constrainToBottom(of: view, with: 48, safely: true)
        footerStackView.constrainHorizontallyTo(titleStackView)
        
        // sorry! Apple doesn't help to do it better 😢
        // it'll conflict with stack leading constraint, but it is just to positioning properly
        // since we don't have an easy way to edit the edge insets of the page control component
        pageControl.constrainToLeading(of: view, with: -16)
    }

}

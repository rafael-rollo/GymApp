//
//  HomeViewController.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

protocol HomeFlowDelegate: AnyObject {
    func carouselBannerDidTap(_ bannerData: BannerData)
}

class HomeViewController: UIViewController {

    // MARK: - subviews
    private lazy var bannerCarousel: BannerCarousel = {
        let carousel = BannerCarousel()
        carousel.translatesAutoresizingMaskIntoConstraints = false
        carousel.delegate = self
        return carousel
    }()
    
    private lazy var checkinStrikes: CheckinStrikes = {
        let strikes = CheckinStrikes()
        strikes.translatesAutoresizingMaskIntoConstraints = false
        return strikes
    }()

    private lazy var contentContainer: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            bannerCarousel,
            checkinStrikes,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentContainer)
        return scrollView
    }()

    // MARK: - properties
    var homeData: HomeData? {
        didSet {
            if let homeData = homeData {
                self.updateViews(with: homeData)
            }
        }
    }
    
    private var flowDelegate: HomeFlowDelegate
    private var profileViewController: ProfileViewController
    private var homeApi: HomeAPI

    // MARK: - view lifecycle
    init(flowDelegate: HomeFlowDelegate,
         profileViewController: ProfileViewController,
         homeApi: HomeAPI) {

        self.flowDelegate = flowDelegate
        self.profileViewController = profileViewController
        self.homeApi = homeApi

        super.init(nibName: nil, bundle: nil)
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
        
        guard let user = Storage.usersAuthentication else { return }
        loadData(for: user)
    }
    
    // TODO: be sure to implement some empty state for subviews
    private func loadData(for user: Authentication) {
        homeApi.getHomeInfo(for: user) { homeData in
            self.homeData = homeData

        } failureHandler: { [weak self] in
            self?.showAlert(withTitle: "Error", message: "Couldn't work. Sorry")
        }
    }

    private func updateViews(with data: HomeData) {
        bannerCarousel.banners = data.banners
    }

}

// MARK: - banner carousel delegation
extension HomeViewController: BannerCarouselDelegate {
    
    func bannerCarouselDelegate(_ carousel: BannerCarousel, didTapBanner data: BannerData) {
        self.flowDelegate.carouselBannerDidTap(data)
    }
    
}

extension HomeViewController: ViewCodeController {
    
    func addTheme() {
        view.backgroundColor = .white
    }
    
    func addViews() {
        view.addSubview(scrollView)
    }
    
    func addChild() {
        addChild(profileViewController)

        let childRootView = profileViewController.view!
        childRootView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(childRootView)
        childRootView.constrainToTopAndSides(of: view)

        profileViewController.didMove(toParent: self)
    }

    func addConstraints() {
        let topMargin = ProfileViewController.LayoutProps.defaultHeight - 12

        scrollView.constrainToTop(of: view, withMargin: topMargin)
        scrollView.constrainToBottomAndSides(of: view)

        contentContainer.constrainToTopAndSides(of: scrollView)
        let bottomConstraint = contentContainer.constrainToBottom(of: scrollView)
        bottomConstraint.priority = .defaultLow

        contentContainer.anchorToCenterX(of: scrollView)
        let centerYConstraint = contentContainer.anchorToCenterY(of: scrollView)
        centerYConstraint.priority = .defaultLow
    }

}

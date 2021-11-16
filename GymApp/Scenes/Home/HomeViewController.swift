//
//  HomeViewController.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

protocol HomeFlowDelegate: AnyObject {
    func toExploreTab()
    func toCheckinTab()
}

class HomeViewController: UIViewController {

    // MARK: - subviews
    private lazy var bannerCarousel: BannerCarousel = {
        let carousel = BannerCarousel()
        carousel.translatesAutoresizingMaskIntoConstraints = false
        return carousel
    }()

    private lazy var contentContainer: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            bannerCarousel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentContainer)
        return scrollView
    }()

    // MARK: - properties
    private var flowDelegate: HomeFlowDelegate
    private var profileViewController: ProfileViewController

    // MARK: - view lifecycle
    init(flowDelegate: HomeFlowDelegate, profileViewController: ProfileViewController) {
        self.flowDelegate = flowDelegate
        self.profileViewController = profileViewController

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
    }
    
    // MARK: - view methods
    @objc func toExploreButtonTapped(_ sender: UIButton) {
        flowDelegate.toExploreTab()
    }

    @objc func toCheckinButtonTapped(_ sender: UIButton) {
        flowDelegate.toCheckinTab()
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

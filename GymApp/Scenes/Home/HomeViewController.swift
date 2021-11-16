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

    private lazy var bannersContentContainer: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            firstView, secondView, thirdView
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()

    private lazy var bannerCarousel: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.addSubview(bannersContentContainer)
        return scrollView
    }()
    
    private lazy var contentContainerView: UIStackView = {
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
        scrollView.addSubview(contentContainerView)
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
        scrollView.anchorBelow(of: profileViewController.view, withMargin: -12)
        scrollView.constrainToBottomAndSides(of: view)

        contentContainerView.constrainToTopAndSides(of: scrollView)
        let bottomConstraint = contentContainerView.constrainToBottom(of: scrollView)
        bottomConstraint.priority = .defaultLow

        contentContainerView.anchorToCenterX(of: scrollView)
        let centerYConstraint = contentContainerView.anchorToCenterY(of: scrollView)
        centerYConstraint.priority = .defaultLow
        
        bannerCarousel.constrainHeight(to: 240)

        bannersContentContainer.constrainTo(edgesOf: bannerCarousel)
        NSLayoutConstraint.activate([
            bannersContentContainer.heightAnchor.constraint(equalTo: bannerCarousel.heightAnchor),
            bannersContentContainer.widthAnchor.constraint(equalTo: bannerCarousel.widthAnchor,
                                                           multiplier: 3),
        ])
    }

}

//
//  HomeViewController.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

protocol HomeFlowDelegate: Coordinator {
    func toExploreTab()
    func toCheckinTab()
}

class HomeViewController: UIViewController {

    // MARK: - subviews
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(.bold, size: 14)
        label.text = "Home Scene!"
        return label
    }()
    
    private lazy var toExploreButton: Button = {
        let button = Button()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = "Go to Explore"
        return button
    }()

    private lazy var toCheckinButton: UIButton = {
        let button = Button()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = "Go to Check-in"
        return button
    }()

    // MARK: - properties
    weak var flowDelegate: HomeFlowDelegate?
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
        
        toExploreButton.addTarget(self, action: #selector(toExploreButtonTapped(_:)), for: .touchUpInside)
        toCheckinButton.addTarget(self, action: #selector(toCheckinButtonTapped(_:)), for: .touchUpInside)
    }
    
    // MARK: - view methods
    @objc func toExploreButtonTapped(_ sender: UIButton) {
        flowDelegate?.toExploreTab()
    }

    @objc func toCheckinButtonTapped(_ sender: UIButton) {
        flowDelegate?.toCheckinTab()
    }

}

extension HomeViewController: ViewCodeController {
    
    func addTheme() {
        view.backgroundColor = .white
    }
    
    func addViews() {
        view.addSubview(label)
        view.addSubview(toExploreButton)
        view.addSubview(toCheckinButton)
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
        label.anchorToCenter(of: view)
        
        toExploreButton.anchorBelow(of: label, withMargin: 42)
        toExploreButton.constrainHorizontally(to: view, withMargins: 48)

        toCheckinButton.anchorBelow(of: toExploreButton, withMargin: 12)
        toCheckinButton.constrainHorizontally(to: view, withMargins: 48)
    }

}

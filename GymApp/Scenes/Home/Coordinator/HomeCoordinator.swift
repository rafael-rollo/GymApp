//
//  HomeCoordinator.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

class HomeCoordinator: StackBasedCoordinator {

    internal var rootViewController: UIViewController?

    var parentCoordinator: TabBasedCoordinator?

    var tab: Tab? {
        return .home
    }

    private var navigationController: UINavigationController

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        let profileViewController = ProfileCoordinator(navigationController: navigationController)
            .start() as! ProfileViewController

        let homeViewController = HomeViewController(
            flowDelegate: self,
            profileViewController: profileViewController
        )

        navigationController.setViewControllers([homeViewController], animated: false)
        navigationController.isNavigationBarHidden = true

        rootViewController = navigationController
        return navigationController
    }
    
    func goToExplore() {
        parentCoordinator?.moveTo(.explore)
    }

    func goToCheckin() {
        parentCoordinator?.moveTo(.checkin)
    }
}

extension HomeCoordinator: HomeFlowDelegate {
    
    func toExploreTab() {
        parentCoordinator?.moveTo(.explore)
    }

    func toCheckinTab() {
        parentCoordinator?.moveTo(.checkin)
    }
    
}

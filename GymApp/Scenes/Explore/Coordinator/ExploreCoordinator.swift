//
//  ExploreCoordinator.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

class ExploreCoordinator: StackBasedCoordinator {

    var parentCoordinator: TabBasedCoordinator?

    var tab: Tab? {
        return .explore
    }
    
    internal var navigationController: UINavigationController
    internal var rootViewController: UIViewController?

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }

    func start() -> UIViewController {
        let controller = ExploreViewController()

        navigationController.setViewControllers([controller], animated: false)
        navigationController.isNavigationBarHidden = true

        rootViewController = controller
        return navigationController
    }

}

//
//  CheckinCoordinator.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

class CheckinCoordinator: StackBasedCoordinator {

    var parentCoordinator: TabBasedCoordinator?

    var tab: Tab? {
        return .checkin
    }
    
    internal var navigationController: UINavigationController
    internal var rootViewController: UIViewController?

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }

    func start() -> UIViewController {
        let controller = CheckinViewController()

        navigationController.setViewControllers([controller], animated: false)
        navigationController.isNavigationBarHidden = true

        rootViewController = controller
        return navigationController
    }

}

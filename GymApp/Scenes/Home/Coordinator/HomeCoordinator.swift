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

    func start() -> UIViewController {
        let controller = UINavigationController(rootViewController: HomeViewController(coordinator: self))
        controller.isNavigationBarHidden = true

        rootViewController = controller
        return controller
    }
    
    func goToExplore() {
        parentCoordinator?.moveTo(.explore)
    }

    func goToCheckin() {
        parentCoordinator?.moveTo(.checkin)
    }
}

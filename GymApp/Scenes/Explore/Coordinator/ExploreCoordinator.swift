//
//  ExploreCoordinator.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

class ExploreCoordinator: StackBasedCoordinator {

    internal lazy var rootViewController: UIViewController? = UIViewController()

    var parentCoordinator: TabBasedCoordinator?

    var tab: Tab? {
        return .explore
    }

    func start() -> UIViewController {
        let controller = UINavigationController(rootViewController: ExploreViewController())
        controller.isNavigationBarHidden = true

        rootViewController = controller
        return controller
    }

}

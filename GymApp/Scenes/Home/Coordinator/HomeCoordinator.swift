//
//  HomeCoordinator.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

class HomeCoordinator: StackBasedCoordinator {

    internal lazy var rootViewController: UIViewController? = UIViewController()

    var parentCoordinator: TabBasedCoordinator?

    var tab: Tab? {
        return .home
    }

    func start() -> UIViewController {
        let controller = UINavigationController(rootViewController: HomeViewController())
        controller.isNavigationBarHidden = true

        rootViewController = controller
        return controller
    }
}

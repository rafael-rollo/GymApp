//
//  ProfileCoordinator.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

class ProfileCoordinator: StackBasedCoordinator {

    internal var rootViewController: UIViewController?

    var parentCoordinator: TabBasedCoordinator?

    var tab: Tab? {
        return .home
    }

    private var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() -> UIViewController {
        let controller = ProfileViewController()

        rootViewController = controller
        return controller
    }
}

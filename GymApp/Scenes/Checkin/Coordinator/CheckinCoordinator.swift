//
//  CheckinCoordinator.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

class CheckinCoordinator: StackBasedCoordinator {

    internal var rootViewController: UIViewController?

    var parentCoordinator: TabBasedCoordinator?

    var tab: Tab? {
        return .checkin
    }

    func start() -> UIViewController {
        let controller = UINavigationController(rootViewController: CheckinViewController())
        controller.isNavigationBarHidden = true

        rootViewController = controller
        return controller
    }

}

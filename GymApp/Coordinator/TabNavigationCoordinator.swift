//
//  TabNavigationCoordinator.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

enum Tab {
    case home
    case explore
    case checkin
}

class TabNavigationCoordinator: NSObject, TabBasedCoordinator {

    internal lazy var rootViewController: UIViewController? = BaseTabBarController()
    var childCoordinators: [StackBasedCoordinator] = []

    func start() -> UIViewController {
        let homeVc = HomeViewController()
        let exploreVc = ExploreViewController()
        let checkinVc = CheckinViewController()
        
        (rootViewController as? BaseTabBarController)?.viewControllers = [homeVc, exploreVc, checkinVc]

        return rootViewController!
    }

    func moveTo(_ tab: Tab) {
        let tabBarController = rootViewController as? UITabBarController

        switch tab {
        case .home:
            tabBarController?.selectedIndex = 0
        case .explore:
            tabBarController?.selectedIndex = 1
        case .checkin:
            tabBarController?.selectedIndex = 2
        }
    }
}

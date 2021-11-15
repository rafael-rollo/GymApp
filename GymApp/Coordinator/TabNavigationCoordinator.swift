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

    internal lazy var rootViewController: UIViewController? = UITabBarController()
    var childCoordinators: [StackBasedCoordinator] = []

    func start() -> UIViewController {
        let tabBarController = rootViewController as? UITabBarController

        let homeVc = HomeViewController()
        let exploreVc = ExploreViewController()
        let checkinVc = CheckinViewController()
        tabBarController?.viewControllers = [homeVc, exploreVc, checkinVc]

        let font = UIFont.openSans(.semibold, size: 10)

        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowColor = .secondaryLabel

        appearance.stackedLayoutAppearance.normal.iconColor = .secondaryLabel
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .font: font,
            .foregroundColor: UIColor.secondaryLabel
        ]

        appearance.stackedLayoutAppearance.selected.iconColor = .shipGray
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .font: font,
            .foregroundColor: UIColor.shipGray!
        ]

        tabBarController?.tabBar.standardAppearance = appearance

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

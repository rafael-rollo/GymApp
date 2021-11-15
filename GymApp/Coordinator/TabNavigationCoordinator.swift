//
//  TabNavigationCoordinator.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

class TabNavigationCoordinator: NSObject, TabBasedCoordinator {

    internal lazy var rootViewController: UIViewController? = BaseTabBarController()
    
    lazy var childCoordinators: [StackBasedCoordinator] = [
        HomeCoordinator(),
        ExploreCoordinator(),
        CheckinCoordinator(),
    ]

    func start() -> UIViewController {
        var viewControllers: [UIViewController] = []

        childCoordinators.forEach { coordinator in
            let rootViewController = coordinator.start()
            rootViewController.tabBarItem = coordinator.tab?.getTabBarItem()

            coordinator.parentCoordinator = self
            viewControllers.append(rootViewController)
        }

        (rootViewController as? BaseTabBarController)?.viewControllers = viewControllers
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

enum Tab {
    case home
    case explore
    case checkin

    func getTabBarItem() -> UITabBarItem {
        switch self {
        case .home:
            let item = UITabBarItem(title: "Home",
                                    image: UIImage(named: "HomeIcon"),
                                    selectedImage: UIImage(named: "HomeFilledIcon"))
            item.tag = 0
            return item

        case .explore:
            let item = UITabBarItem(title: "Explore",
                                    image: UIImage(named: "ExploreIcon"),
                                    selectedImage: UIImage(named: "ExploreFilledIcon"))
            item.tag = 1
            return item

        case .checkin:
            let item = UITabBarItem(title: "Check-in",
                                    image: UIImage(named: "CheckinIcon"),
                                    selectedImage: UIImage(named: "CheckinFilledIcon"))
            item.tag = 2
            return item
        }
    }
}

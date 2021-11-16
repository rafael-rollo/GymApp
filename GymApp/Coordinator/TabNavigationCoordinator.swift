//
//  TabNavigationCoordinator.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

class TabNavigationCoordinator: NSObject, TabBasedCoordinator {

    internal var rootViewController: UIViewController?
    
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

        let tabBarViewController = BaseTabBarController()
        tabBarViewController.viewControllers = viewControllers

        rootViewController = tabBarViewController
        return tabBarViewController
    }

    // TODO: Create some Deeplink coordinator to handle navigation infered by the backend responses
    func moveTo(_ tab: Tab, passing navigationParams: [String: Any]? = nil) {
        let tabIndex = tab.getTabBarItem().tag

        if let coordinated = childCoordinators[tabIndex].rootViewController as? Coordinated {
            coordinated.navigationParams = navigationParams
        }

        let tabBarController = rootViewController as? UITabBarController
        tabBarController?.selectedIndex = tab.getTabBarItem().tag
    }
}

enum Tab: String {
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

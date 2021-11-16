//
//  HomeCoordinator.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

class HomeCoordinator: StackBasedCoordinator {

    var parentCoordinator: TabBasedCoordinator?

    var tab: Tab? {
        return .home
    }

    internal var navigationController: UINavigationController
    internal var rootViewController: UIViewController?

    // dependencies to inject
    private var homeApi: HomeAPI

    init(navigationController: UINavigationController = UINavigationController(),
         homeApi: HomeAPI = HomeAPI()) {
        self.navigationController = navigationController
        self.homeApi = homeApi
    }
    
    func start() -> UIViewController {
        let profileViewController = ProfileCoordinator(navigationController: navigationController)
            .start() as! ProfileViewController

        let homeViewController = HomeViewController(
            flowDelegate: self,
            profileViewController: profileViewController,
            homeApi: homeApi
        )

        navigationController.setViewControllers([homeViewController], animated: false)
        navigationController.isNavigationBarHidden = true

        rootViewController = navigationController
        return navigationController
    }
    
    func goToExplore() {
        parentCoordinator?.moveTo(.explore)
    }

    func goToCheckin() {
        parentCoordinator?.moveTo(.checkin)
    }
}

extension HomeCoordinator: HomeFlowDelegate {
    
    func carouselBannerDidTap(_ bannerData: BannerData) {
        guard let bannerDestination = bannerData.destination else { return }

        guard let tab = Tab(rawValue: bannerDestination.tab) else { return }

        parentCoordinator?.moveTo(tab, passing: bannerDestination.bag)
    }
    
    func toExploreTab() {
        parentCoordinator?.moveTo(.explore)
    }

    func toCheckinTab() {
        parentCoordinator?.moveTo(.checkin)
    }
    
}

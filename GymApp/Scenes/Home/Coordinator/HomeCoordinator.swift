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
    
    private var isPresentingModal: Bool = false

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
    
    private func showUsersUsageStatsPage() {
        let url = "https://gympass.com"
        guard let url = URL(string: url) else { return }

        let webview = WebViewController(path: url, flowDelegate: self)
        webview.modalPresentationStyle = .fullScreen

        navigationController.present(webview, animated: true) { [weak self] in
            self?.isPresentingModal.toggle()
        }
    }
    
    private func showWellnessPage(for app: WellnessAppData) {
        let url = "https://gympass.com?app=\(app.slug)"
        guard let url = URL(string: url) else { return }

        let webview = WebViewController(path: url, flowDelegate: self)
        webview.modalPresentationStyle = .fullScreen

        navigationController.present(webview, animated: true) { [weak self] in
            self?.isPresentingModal.toggle()
        }
    }
    
}

extension HomeCoordinator: HomeFlowDelegate {
    
    func carouselBannerDidTap(_ bannerData: BannerData) {
        guard let bannerDestination = bannerData.destination else { return }

        guard let tab = Tab(rawValue: bannerDestination.tab) else { return }

        parentCoordinator?.moveTo(tab, passing: bannerDestination.bag)
    }
    
    func userStrikesDidTap() {
        showUsersUsageStatsPage()
    }
    
    func wellnessAppDidTap(_ appData: WellnessAppData) {
        showWellnessPage(for: appData)
    }
    
}

extension HomeCoordinator: WebViewFlowDelegate {
    
    func webViewDidClose() {
        guard isPresentingModal else { return }

        navigationController.dismiss(animated: true) { [weak self] in
            self?.isPresentingModal.toggle()
        }
    }
    
}

//
//  ApplicationCoordinator.swift
//  GymApp
//
//  Created by rafael.rollo on 11/11/21.
//

import UIKit
import Lottie
import CoreLocation

class ApplicationCoordinator: Coordinator {

    // MARK: - properties
    let window: UIWindow

    internal var rootViewController: UIViewController? {
        didSet {
            UIView.transition(
                with: window,
                duration: 0.5,
                options: .transitionCrossDissolve,
                animations: nil,
                completion: nil
            )

            window.rootViewController = rootViewController
            window.makeKeyAndVisible()
        }
    }
    
    // MARK: - dependencies to be injected
    private lazy var locationManager = CLLocationManager()
    private lazy var users = Users()

    init(window: UIWindow) {
        self.window = window
    }

    @discardableResult func start() -> UIViewController {
        let initialViewController = LaunchViewController(delegate: self)
        rootViewController = initialViewController

        return initialViewController
    }
}

extension ApplicationCoordinator: LaunchViewControllerDelegate {
    
    func launchViewController(_ viewController: LaunchViewController,
                              animationDidFinish animation: AnimationView) {
        guard Storage.walkthroughHasAlreadyBeenSeen else {
            rootViewController = WalkthroughViewController(delegate: self)
            return
        }

        guard Storage.locationPermissionHasAlreadyBeenRequested else {
            rootViewController = LocationPermissionViewController(delegate: self, locationManager: self.locationManager)
            return
        }

        guard Storage.isUserLogged else {
            rootViewController = LoginViewController(delegate: self, users: users)
            return
        }

        goToHome()
    }
    
}

extension ApplicationCoordinator: WalkthroughViewControllerDelegate {
    
    func walkthroughViewControllerDidComplete(_ viewController: WalkthroughViewController) {
        rootViewController = LocationPermissionViewController(delegate: self, locationManager: self.locationManager)
    }
    
}

extension ApplicationCoordinator: LocationPermissionViewControllerDelegate {
    
    func locationPermissionViewController(_ viewController: LocationPermissionViewController, didRequest authorizationStatus: CLAuthorizationStatus) {
        rootViewController = LoginViewController(delegate: self, users: users)
    }
    
}

extension ApplicationCoordinator: LoginViewControllerDelegate {
    
    private func goToHome() {
        let tabBarController = UITabBarController()

        let homeVc = HomeViewController()
        let exploreVc = ExploreViewController()
        let checkinVc = CheckinViewController()
        tabBarController.viewControllers = [homeVc, exploreVc, checkinVc]

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

        tabBarController.tabBar.standardAppearance = appearance


        rootViewController = tabBarController
    }
    
    func loginViewController(_ viewController: LoginViewController,
                             didUserAuthenticate authentication: Authentication) {
        goToHome()
    }
    
}

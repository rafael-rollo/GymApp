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
            rootViewController = LocationPermissionViewController(delegate: self)
            return
        }

        rootViewController = LoginViewController()
    }
    
}

extension ApplicationCoordinator: WalkthroughViewControllerDelegate {
    
    func walkthroughViewControllerDidComplete(_ viewController: WalkthroughViewController) {
        rootViewController = LocationPermissionViewController(delegate: self)
    }
    
}

extension ApplicationCoordinator: LocationPermissionViewControllerDelegate {
    
    func locationPermissionViewController(_ viewController: LocationPermissionViewController, didRequest authorizationStatus: CLAuthorizationStatus) {
        rootViewController = LoginViewController()
    }
    
}

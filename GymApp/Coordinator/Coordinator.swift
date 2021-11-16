//
//  Coordinator.swift
//  GymApp
//
//  Created by rafael.rollo on 11/11/21.
//

import UIKit

protocol Coordinated: UIViewController {
    var navigationParams: [String: Any]? { get set }
}

protocol Coordinator: AnyObject {
    var rootViewController: UIViewController? { get set }

    @discardableResult func start() -> UIViewController
}

protocol TabBasedCoordinator: Coordinator {
    var childCoordinators: [StackBasedCoordinator] { get set }

    func moveTo(_ tab: Tab)
    func moveTo(_ tab: Tab, passing navigationParams: [String: Any]?)
}

extension TabBasedCoordinator {
    func moveTo(_ tab: Tab) { }
    func moveTo(_ tab: Tab, passing navigationParams: [String: Any]? = nil) { }
}

protocol StackBasedCoordinator: Coordinator {
    var navigationController: UINavigationController { get set }
    
    var tab: Tab? { get }
    var parentCoordinator: TabBasedCoordinator? { get set }
}

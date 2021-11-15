//
//  Coordinator.swift
//  GymApp
//
//  Created by rafael.rollo on 11/11/21.
//

import UIKit

protocol Coordinated: UIViewController {
    var coordinator: Coordinator { get set }
}

protocol Coordinator: AnyObject {
    var rootViewController: UIViewController? { get set }

    @discardableResult func start() -> UIViewController
}

protocol TabBasedCoordinator: Coordinator {
    var childCoordinators: [StackBasedCoordinator] { get set }

    func moveTo(_ tab: Tab)
}

protocol StackBasedCoordinator: Coordinator {
    var tab: Tab? { get }
    var parentCoordinator: TabBasedCoordinator? { get set }
}

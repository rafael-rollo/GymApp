//
//  Coordinator.swift
//  GymApp
//
//  Created by rafael.rollo on 11/11/21.
//

import UIKit

protocol Coordinator: AnyObject {
    var rootViewController: UIViewController? { get set }

    @discardableResult func start() -> UIViewController
}

protocol TabBasedCoordinator: Coordinator {
    var childCoordinators: [StackBasedCoordinator] { get set }

    func moveTo(_ tab: Tab)
}

protocol StackBasedCoordinator: Coordinator {
    var parentCoordinator: [TabBasedCoordinator]? { get set }
}

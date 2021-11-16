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

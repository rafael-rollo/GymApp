//
//  BaseTabBarController.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

class BaseTabBarController: UITabBarController {

    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setup() {
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

        self.tabBar.standardAppearance = appearance
    }
    
}

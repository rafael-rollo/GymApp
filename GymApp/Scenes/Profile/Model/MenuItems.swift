//
//  MenuItems.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import Foundation

struct MenuItem {
    var imageName: String
    var title: String
    var externalLink: String?
    var submenuItems: [MenuItem]?

    var isFinal: Bool {
        return self.externalLink != nil
    }
}

struct MenuItems {
    var title: String
    var items: [MenuItem]

    static let allItems: [MenuItems] = [
        MenuItems(title: "Account", items: [
            MenuItem(imageName: "GearIcon",
                     title: "Plan management",
                     externalLink: "https://gympass.com"),
            MenuItem(imageName: "PeopleIcon",
                     title: "Dependents",
                     externalLink: "https://gympass.com"),
            MenuItem(imageName: "PersonIcon",
                     title: "Edit profile",
                     externalLink: "https://gympass.com"),
            MenuItem(imageName: "WalletIcon",
                     title: "Payments",
                     submenuItems: [
                        MenuItem(imageName: "CoinIcon",
                                 title: "Available credit",
                                 externalLink: "https://gympass.com"),
                        MenuItem(imageName: "CreditCardIcon",
                                 title: "Payment method",
                                 externalLink: "https://gympass.com"),
                        MenuItem(imageName: "ReceiptIcon",
                                 title: "Payment history",
                                 externalLink: "https://gympass.com"),
                     ]),
            MenuItem(imageName: "HistoryIcon",
                      title: "Check-in history",
                      externalLink: "https://gympass.com"),
        ]),
        MenuItems(title: "About Gym.app", items: [
            MenuItem(imageName: "BellIcon",
                     title: "Notifications",
                     externalLink: "https://gympass.com"),
            MenuItem(imageName: "HelpIcon",
                     title: "Help center",
                     externalLink: "https://gympass.com"),
            MenuItem(imageName: "DumbbellIcon",
                     title: "Refer a facility",
                     externalLink: "https://gympass.com"),
            MenuItem(imageName: "PadlockIcon",
                     title: "Privacy and security",
                     submenuItems: [
                        MenuItem(imageName: "KeyIcon",
                                 title: "Password",
                                 externalLink: "https://gympass.com"),
                        MenuItem(imageName: "ShieldIcon",
                                 title: "Personal data",
                                 externalLink: "https://gympass.com"),
                        MenuItem(imageName: "FileIcon",
                                 title: "Terms and conditions",
                                 externalLink: "https://gympass.com"),
                     ]),
        ])
    ]
}

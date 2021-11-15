//
//  ProfileCoordinator.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

class ProfileCoordinator: StackBasedCoordinator {

    internal var rootViewController: UIViewController?

    var parentCoordinator: TabBasedCoordinator?

    var tab: Tab? {
        return .home
    }

    private var navigationController: UINavigationController
    
    private var isPresentingModal: Bool = false

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() -> UIViewController {
        let controller = ProfileViewController(flowDelegate: self)

        rootViewController = controller
        return controller
    }
    
    func openExternalLink(of item: MenuItem) {
        guard let externalLink = item.externalLink,
              let url = URL(string: externalLink) else { return }

        let webview = WebViewController(path: url, flowDelegate: self)
        webview.modalPresentationStyle = .fullScreen

        navigationController.present(webview, animated: true) { [weak self] in
            self?.isPresentingModal.toggle()
        }
    }
    
    func navigateToSubmenu(of item: MenuItem) {
        guard let items = item.submenuItems else { return }

        let menu = MenuViewController(items: items, flowDelegate: self)
        menu.title = item.title

        navigationController.pushViewController(menu, animated: true)
    }
    
}

extension ProfileCoordinator: ProfileFlowDelegate {
    
    func menuItemDidSelect(_ item: MenuItem) {
        if item.isFinal {
            openExternalLink(of: item)
        } else {
            navigateToSubmenu(of: item)
        }
    }
    
}

extension ProfileCoordinator: WebViewFlowDelegate {
    
    func webViewDidClose() {
        guard isPresentingModal else { return }

        navigationController.dismiss(animated: true) { [weak self] in
            self?.isPresentingModal.toggle()
        }
    }
    
}

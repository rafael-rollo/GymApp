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
    
    func openExternalLink(_ url: URL) {
        let webview = WebViewController(path: url, flowDelegate: self)
        webview.modalPresentationStyle = .fullScreen

        navigationController.present(webview, animated: true) { [weak self] in
            self?.isPresentingModal.toggle()
        }
    }
    
}

extension ProfileCoordinator: ProfileFlowDelegate {
    
    func menuItemDidSelect(_ item: MenuItem) {
        guard let externalLink = item.externalLink else {
            // navigateToSubmenuScene()
            return
        }

        guard let url = URL(string: externalLink) else { return }
        openExternalLink(url)
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

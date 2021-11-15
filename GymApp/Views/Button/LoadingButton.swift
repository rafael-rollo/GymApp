//
//  LoadingButton.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit
import Lottie

class LoadingButton: Button {

    private var isLoading: Bool = false {
        didSet {
            isLoading ? addLottieView() : removeLottieView()
        }
    }

    private var loadingAnimation: AnimationView?

    private func addLottieView() {
        loadingAnimation = AnimationView(name: "LoadingAnimation")
        loadingAnimation!.translatesAutoresizingMaskIntoConstraints = false
        loadingAnimation!.contentMode = .scaleAspectFit
        self.addSubview(loadingAnimation!)

        NSLayoutConstraint.activate([
            loadingAnimation!.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingAnimation!.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loadingAnimation!.widthAnchor.constraint(equalTo: self.widthAnchor),
            loadingAnimation!.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])

        loadingAnimation!.loopMode = .loop
        loadingAnimation!.play()
    }

    private func removeLottieView() {
        guard let loadingAnimation = loadingAnimation else { return }

        loadingAnimation.stop()
        loadingAnimation.removeFromSuperview()
        self.loadingAnimation = nil
    }

    func startLoading() {
        isEnabled = false
        
        UIView.transition(with: self,
                          duration: 0.3,
                          options: .curveEaseInOut) { [weak self] in
            self?.backgroundColor = .tertiaryLabel
            self?.titleLabel?.alpha = 0.0
        } completion: { [weak self] _ in
            self?.isLoading = true
        }
    }

    func stopLoading() {
        guard isLoading else { return }
        
        isEnabled = true

        UIView.transition(with: self,
                          duration: 0.3,
                          options: .curveEaseInOut) { [weak self] in
            self?.backgroundColor = self?.style.backgroundColor
            self?.titleLabel?.alpha = 1.0
        } completion: { [weak self] _ in
            self?.isLoading = false
        }
    }
}

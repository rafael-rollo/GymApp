//
//  ViewController.swift
//  GymApp
//
//  Created by rafael.rollo on 10/11/21.
//

import UIKit
import Lottie

protocol LaunchViewControllerDelegate: AnyObject {
    func launchViewController(_ viewController: LaunchViewController,
                              animationDidFinish animation: AnimationView)
}

class LaunchViewController: UIViewController {
    
    weak var delegate: LaunchViewControllerDelegate?

    private lazy var animation: AnimationView = {
        let animation = AnimationView(name: "LaunchAnimation")
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.frame = view.bounds
        animation.contentMode = .scaleAspectFit
        animation.animationSpeed = 1
        return animation
    }()

    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animation.play(fromFrame: 0, toFrame: 86, loopMode: .playOnce) { [weak self] _ in
            guard let self = self else { return }
            self.delegate?.launchViewController(self, animationDidFinish: self.animation)
        }
    }
    
    init(delegate: LaunchViewControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension LaunchViewController: ViewCode {
    
    func addTheme() {
        view.backgroundColor = UIColor(named: "Terracotta")
    }
    
    func addViews() {
        view.addSubview(animation)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            animation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animation.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}

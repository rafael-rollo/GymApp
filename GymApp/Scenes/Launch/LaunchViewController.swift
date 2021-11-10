//
//  ViewController.swift
//  GymApp
//
//  Created by rafael.rollo on 10/11/21.
//

import UIKit
import Lottie

class LaunchViewController: UIViewController {

    private lazy var animation: AnimationView = {
        let animation = AnimationView(name: "LaunchAnimation")
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.frame = view.bounds
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .playOnce
        animation.animationSpeed = 1
        return animation
    }()

    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animation.play(toFrame: 86)
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

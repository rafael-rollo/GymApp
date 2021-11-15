//
//  HomeViewController.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

class HomeViewController: UIViewController {

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(.bold, size: 14)
        label.text = "Home Scene!"
        return label
    }()

    override func loadView() {
        super.loadView()
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension HomeViewController: ViewCode {
    
    func addTheme() {
        view.backgroundColor = .white
    }
    
    func addViews() {
        view.addSubview(label)
    }

    func addConstraints() {
        label.anchorToCenter(of: view)
    }

}

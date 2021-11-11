//
//  LocationPermissionViewController.swift
//  GymApp
//
//  Created by rafael.rollo on 11/11/21.
//

import UIKit

class LocationPermissionViewController: UIViewController {

    // MARK: - subviews
    private lazy var shape: AnimatedShape = {
        let shape = AnimatedShape()
        shape.translatesAutoresizingMaskIntoConstraints = false
        return shape
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(.bold, size: UIFont.labelFontSize)
        label.text = "Ask user's location permission"
        return label
    }()

    override func loadView() {
        super.loadView()
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        shape.animate()
    }
    
}

extension LocationPermissionViewController: ViewCode {
    
    func addTheme() {
        view.backgroundColor = .white
    }
    
    func addViews() {
        view.addSubview(shape)
        view.addSubview(label)
    }

    func addConstraints() {
        let shapeXOffset = shape.bounds.width * 0.37
        let shapeYOffset = shape.bounds.height - view.bounds.height * 0.3

        NSLayoutConstraint.activate([
            shape.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: -shapeXOffset),
            shape.topAnchor.constraint(equalTo: view.topAnchor,
                                       constant: -shapeYOffset)
        ])
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}

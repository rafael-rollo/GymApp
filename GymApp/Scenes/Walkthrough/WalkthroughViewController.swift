//
//  WalkthroughViewController.swift
//  GymApp
//
//  Created by rafael.rollo on 11/11/21.
//

import UIKit

enum ShapeRotationDegree: CGFloat {
    case original = -145
    case firstStep = -130
    case secondStep = -160
    case thirdStep = -190
}

class WalkthroughViewController: UIViewController {
    
    private var currentStep: Int = 0

    private lazy var upperShape: UIImageView = {
        let shape = UIImageView(
            image: UIImage(named: "AnimatedShape")
        )
        shape.translatesAutoresizingMaskIntoConstraints = false
        shape.transform = CGAffineTransform(rotationAngle: .angle(ShapeRotationDegree.original.rawValue))
        return shape
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Walkthrough Scene!"
        return label
    }()

    override func loadView() {
        super.loadView()
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animate(withDuration: 1.0) {
            
            let rad = CGFloat.angle(ShapeRotationDegree.firstStep.rawValue)
            self.upperShape.transform = CGAffineTransform(rotationAngle: rad)
        }
    }
}

extension WalkthroughViewController: ViewCode {
    
    func addTheme() {
        view.backgroundColor = .white
    }
    
    func addViews() {
        view.addSubview(upperShape)
        view.addSubview(label)
    }

    func addConstraints() {
        let upperShapeXOffset = -(upperShape.bounds.width * 0.4)
        let upperShapeYOffset = -(upperShape.bounds.height * 0.4)
        NSLayoutConstraint.activate([
            upperShape.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: upperShapeXOffset),
            upperShape.topAnchor.constraint(equalTo: view.topAnchor, constant: upperShapeYOffset)
        ])
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}

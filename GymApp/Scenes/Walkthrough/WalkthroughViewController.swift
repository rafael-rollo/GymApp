//
//  WalkthroughViewController.swift
//  GymApp
//
//  Created by rafael.rollo on 11/11/21.
//

import UIKit

class WalkthroughViewController: UIViewController {

    // MARK: - subviews
    private lazy var upperShape: RotatingShape = {
        let shape = RotatingShape()
        shape.translatesAutoresizingMaskIntoConstraints = false
        return shape
    }()
    
    private lazy var logo: UIImageView = {
        let logo = UIImage(named: "GymAppLogo")?.withTintColor(.white)
        let imageView = UIImageView(image: logo)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var skipButton: UIButton = {
        let atributedTitle = NSAttributedString(string: "Skip", attributes: [
            .foregroundColor: UIColor(named: "Relax") ?? .purple,
            .font: UIFont.openSans(.bold, size: UIFont.smallSystemFontSize)
        ])

        let button = UIButton()
        button.setAttributedTitle(atributedTitle, for: .normal)
        return button
    }()

    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            logo,
            skipButton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var aView: UIView = {
        return UIView()
    }()

    private lazy var nextButton: UIButton = {
        let image = UIImage(systemName: "arrow.forward")?
            .withRenderingMode(.alwaysTemplate)

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "Terracotta")
        button.tintColor = .white
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 24
        button.layer.masksToBounds = true
        return button
    }()

    private lazy var footerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            aView,
            nextButton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(.bold, size: UIFont.labelFontSize)
        label.text = "Walkthrough Scene!"
        return label
    }()

    // MARK: - view lifecycle
    override func loadView() {
        super.loadView()
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        upperShape.rotate(by: RotatingShape.Angles.firstStep)
    }
}

// MARK: - view code
extension WalkthroughViewController: ViewCode {
    
    func addTheme() {
        view.backgroundColor = .white
    }
    
    func addViews() {
        view.addSubview(upperShape)
        view.addSubview(titleStackView)
        view.addSubview(label)
        view.addSubview(footerStackView)
    }

    func addConstraints() {
        let upperShapeXOffset = upperShape.bounds.width * 0.37
        let upperShapeYOffset = upperShape.bounds.height - view.bounds.height * 0.3
        
        NSLayoutConstraint.activate([
            upperShape.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -upperShapeXOffset),
            upperShape.topAnchor.constraint(equalTo: view.topAnchor, constant: -upperShapeYOffset)
        ])
        
        NSLayoutConstraint.activate([
            logo.widthAnchor.constraint(equalToConstant: 120),
        ])
        
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            titleStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nextButton.widthAnchor.constraint(equalToConstant: 48),
            nextButton.heightAnchor.constraint(equalToConstant: 48)
        ])

        NSLayoutConstraint.activate([
            footerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
            footerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            footerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }

}

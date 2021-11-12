//
//  LoginViewController.swift
//  GymApp
//
//  Created by rafael.rollo on 11/11/21.
//

import UIKit

class LoginViewController: UIViewController {

    private lazy var logo: UIImageView = {
        let logo = UIImage(named: "GymAppLogo")?
            .withTintColor(.terracotta ?? .systemRed)

        let imageView = UIImageView(image: logo)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(.bold, size: 20)
        label.textColor = .shipGray
        label.text = "Enter your email"
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(size: 14)
        label.textColor = .secondaryLabel
        label.text = "It's the one you used to sign up for Gym.app"
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var titlesView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            titleLabel, descriptionLabel
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 12
        return view
    }()

    private lazy var emailTextInput: TextInput = {
        let input = TextInput()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.title = "Email address"
        return input
    }()

    override func loadView() {
        super.loadView()
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension LoginViewController: ViewCode {
    
    func addTheme() {
        view.backgroundColor = .white
    }
    
    func addViews() {
        view.addSubview(logo)
        view.addSubview(titlesView)
        view.addSubview(emailTextInput)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            logo.widthAnchor.constraint(equalToConstant: 120),
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            logo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])

        NSLayoutConstraint.activate([
            titlesView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 24),
            titlesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titlesView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])

        NSLayoutConstraint.activate([
            emailTextInput.topAnchor.constraint(equalTo: titlesView.bottomAnchor, constant: 24),
            emailTextInput.leadingAnchor.constraint(equalTo: titlesView.leadingAnchor),
            emailTextInput.trailingAnchor.constraint(equalTo: titlesView.trailingAnchor),
        ])
    }

}

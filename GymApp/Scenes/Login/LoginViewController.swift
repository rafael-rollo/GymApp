//
//  LoginViewController.swift
//  GymApp
//
//  Created by rafael.rollo on 11/11/21.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - subviews
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
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var switchAccountButton: UIButton = {
        let image = UIImage(named: "PencilIcon")?
            .withTintColor(.secondaryLabel)

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.isHidden = true
        return button
    }()

    private lazy var buttonWrapper: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(switchAccountButton)
        return view
    }()

    private lazy var descriptionStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            descriptionLabel, buttonWrapper
        ])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 4
        return stack
    }()

    private lazy var titlesView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            titleLabel, descriptionStack
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
        input.keyboardType = .emailAddress
        input.autocapitalizationType = .none
        input.maxLength = 46
        input.title = "Email address"
        return input
    }()
    
    private lazy var passwordTextInput: TextInput = {
        let input = TextInput()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.autocapitalizationType = .none
        input.title = "Password"
        input.isSecureTextEntry = true
        return input
    }()
    
    private lazy var submitButton: Button = {
        let button = Button()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.style = .secondary
        return button
    }()
    
    // MARK: - properties
    private var state: LoginState = .undeterminedUser {
        didSet {
            self.updateViews()
        }
    }

    private weak var users: Users?

    // MARK: - view lifecycle
    init(users: Users) {
        self.users = users
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
        submitButton.addTarget(self,
                               action: #selector(submitButtonPressed(_:)),
                               for: .touchUpInside)
        
        switchAccountButton.addTarget(self,
                                      action: #selector(switchAccount),
                                      for: .touchUpInside)
    }
    
    // MARK: - view methods
    private func updateViews() {
        let form = state.formInfo()

        titleLabel.text = form.title
        descriptionLabel.text = form.description ?? emailTextInput.text
        switchAccountButton.isHidden = !form.switchableAccount

        emailTextInput.isHidden = !form.emailFieldVisible
        passwordTextInput.isHidden = !form.passwordFieldVisible

        submitButton.setTitle(form.buttonTitle, for: .normal)
    }

    @objc private func submitButtonPressed(_ sender: UIButton) {
        switch state {
        case .undeterminedUser:
            findUserAccount()

        case .identifiedAccount:
            authenticateUser()
        }
    }

    private func findUserAccount() {
        users?.findUserAccount(by: emailTextInput.text!) { [weak self] _ in
            self?.state = .identifiedAccount

        } failureHandler: { [weak self] in
            self?.showAlert(withTitle: "Error", message: "Couldn't work.")
        }
    }

    @objc private func switchAccount() {
        state = .undeterminedUser
    }
    
    private func authenticateUser() {
        print("authenticate")
    }
}

// MARK: - view code
extension LoginViewController: ViewCode {
    
    func addTheme() {
        view.backgroundColor = .white
    }
    
    func addViews() {
        view.addSubview(logo)
        view.addSubview(titlesView)
        view.addSubview(emailTextInput)
        view.addSubview(passwordTextInput)
        view.addSubview(submitButton)
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
            switchAccountButton.widthAnchor.constraint(equalToConstant: 18),
            switchAccountButton.heightAnchor.constraint(equalToConstant: 18)
        ])

        NSLayoutConstraint.activate([
            emailTextInput.topAnchor.constraint(equalTo: titlesView.bottomAnchor, constant: 24),
            emailTextInput.leadingAnchor.constraint(equalTo: titlesView.leadingAnchor),
            emailTextInput.trailingAnchor.constraint(equalTo: titlesView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            passwordTextInput.topAnchor.constraint(equalTo: titlesView.bottomAnchor, constant: 24),
            passwordTextInput.leadingAnchor.constraint(equalTo: titlesView.leadingAnchor),
            passwordTextInput.trailingAnchor.constraint(equalTo: titlesView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: emailTextInput.bottomAnchor, constant: 32),
            submitButton.leadingAnchor.constraint(equalTo: titlesView.leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: titlesView.trailingAnchor),
        ])
    }

}

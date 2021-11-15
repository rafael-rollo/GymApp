//
//  LoginViewController.swift
//  GymApp
//
//  Created by rafael.rollo on 11/11/21.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func loginViewController(_ viewController: LoginViewController,
                             didUserAuthenticate authentication: Authentication)
}

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
        input.autocorrectionType = .no
        input.maxLength = 46
        input.title = "Email address"
        input.rules = [.notEmpty, .validEmail]
        emailValidator.requireValidation(on: input)
        return input
    }()
    
    private lazy var passwordTextInput: TextInput = {
        let input = TextInput()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.autocapitalizationType = .none
        input.title = "Password"
        input.isSecureTextEntry = true
        input.rules = [.notEmpty]
        passwordValidator.requireValidation(on: input)
        return input
    }()
    
    private lazy var submitButton: LoadingButton = {
        let button = LoadingButton()
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
    
    private var emailValidator = Validator()
    private var passwordValidator = Validator()

    private weak var delegate: LoginViewControllerDelegate?
    private weak var users: Users?

    // MARK: - view lifecycle
    init(delegate: LoginViewControllerDelegate, users: Users) {
        self.delegate = delegate
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

        submitButton.title = form.buttonTitle
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
        guard emailValidator.isFormValid() else { return }
        
        submitButton.startLoading()
        
        users?.findUserAccount(by: emailTextInput.text!) { [weak self] _ in
            // hold some user's account data
            
            self?.state = .identifiedAccount
            self?.submitButton.stopLoading()

        } failureHandler: { [weak self] in
            self?.showAlert(withTitle: "Error", message: "Couldn't work.")
        }
    }

    @objc private func switchAccount() {
        state = .undeterminedUser
    }
    
    private func authenticateUser() {
        guard passwordValidator.isFormValid() else { return }
        
        submitButton.startLoading()
        
        users?.getAuthentication(from: passwordTextInput.text!) { [weak self] authentication in
            // hold some user's authentication data
            Storage.usersAuthentication = authentication
            
            self?.delegate?.loginViewController(self!, didUserAuthenticate: authentication)
            self?.submitButton.stopLoading()

        } failureHandler: { [weak self] in
            self?.showAlert(withTitle: "Error", message: "Couldn't work. Sorry.")
        }
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
        logo.constrainWidth(to: 120)
        logo.constrainToTopAndLeading(of: view, topMargin: 48,
                                   leadingMargin: 16, notchSafe: true)

        titlesView.anchorBelow(of: logo, withMargin: 24)
        titlesView.constrainHorizontally(to: view, withMargins: 24)
        
        switchAccountButton.constrainSize(to: CGSize(width: 18, height: 18))
        
        emailTextInput.anchorBelow(of: titlesView, withMargin: 24)
        emailTextInput.constrainHorizontally(to: titlesView)
        
        passwordTextInput.anchorBelow(of: titlesView, withMargin: 24)
        passwordTextInput.constrainHorizontally(to: titlesView)
        
        submitButton.anchorBelow(of: emailTextInput, withMargin: 38)
        submitButton.constrainHorizontally(to: titlesView)
    }

}

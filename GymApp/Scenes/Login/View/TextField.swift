//
//  TextField.swift
//  GymApp
//
//  Created by rafael.rollo on 12/11/21.
//

import UIKit

class TextInput: UIView {
    
    private struct TitlePositions {
        static var t0: CGPoint = .init(x: 12, y: 12)
        static var t1: CGPoint = .init(x: 12, y: -10)
    }

    // MARK: - subviews
    private lazy var fieldTitleLabel: UIButton = {
        let label = UIButton() // just to have the content inset support, sorry!
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        label.titleLabel?.font = .openSans(size: 12)
        label.setTitleColor(.shipGray, for: .normal)
        label.backgroundColor = .white
        label.isUserInteractionEnabled = false
        label.alpha = 0
        label.backgroundColor = .clear
        return label
    }()

    private lazy var textField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = .openSans(size: 12)
        field.textColor = .shipGray
        field.delegate = self
        field.addTarget(self,
                        action: #selector(textFieldDidChange(_:)),
                        for: .editingChanged)
        return field
    }()

    private lazy var textFieldView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.shipGray?.cgColor

        view.addSubview(textField)
        return view
    }()
    
    // MARK: - properties
    private var titleTopConstraint: NSLayoutConstraint?
    private var titleLeadingConstraint: NSLayoutConstraint?

    private var isTitleVisible: Bool = false {
        didSet {
            isTitleVisible ? titleGoesUp() : titleGoesDown()
        }
    }

    var title: String? {
        didSet {
            textField.placeholder = title
            fieldTitleLabel.setTitle(title, for: .normal)
        }
    }
    
    var text: String? {
        get {
            return textField.text
        }
        set {
            textField.text = newValue
        }
    }

    var isSecureTextEntry: Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecureTextEntry
        }
    }

    // MARK: - view lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
        textFieldView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(textFieldTapped))
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - view methods
    @objc private func textFieldTapped() {
        textField.becomeFirstResponder()
    }

    @objc private func textFieldDidChange(_ sender: UITextField) {
        guard let textLength = sender.text?.count else { return }

        guard textLength > 0 else { return }

        if !isTitleVisible {
            isTitleVisible = true
        }
    }

    private func titleGoesUp() {
        titleLeadingConstraint?.constant = TitlePositions.t1.x
        titleTopConstraint?.constant = TitlePositions.t1.y

        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.fieldTitleLabel.titleLabel?.font = .openSans(.bold, size: 12)
            self?.fieldTitleLabel.alpha = 1
            self?.fieldTitleLabel.backgroundColor = .white

            self?.layoutIfNeeded()
        }
    }

    private func titleGoesDown() {
        titleLeadingConstraint?.constant = TitlePositions.t0.x
        titleTopConstraint?.constant = TitlePositions.t0.y

        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.fieldTitleLabel.titleLabel?.font = .openSans(size: 12)
            self?.fieldTitleLabel.alpha = 0
            self?.fieldTitleLabel.backgroundColor = .clear

            self?.layoutIfNeeded()
        }
    }
}

// MARK: - text input handling
extension TextInput: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let   text = textField.text as NSString? else { return true }

        let updateProjection = text.replacingCharacters(in: range, with: string)

        if updateProjection.isEmpty {
            isTitleVisible = false
        }

        return true
    }
}

// MARK: - view code

extension TextInput: ViewCode {
    func addViews() {
        addSubview(textFieldView)
        addSubview(fieldTitleLabel)
    }

    func addConstraints() {
        heightAnchor.constraint(equalToConstant: 60).isActive = true

        NSLayoutConstraint.activate([
            textFieldView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textFieldView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textFieldView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textFieldView.heightAnchor.constraint(equalToConstant: 50),
        ])

        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -16),
            textField.centerYAnchor.constraint(equalTo: textFieldView.centerYAnchor, constant: -1)
        ])

        titleLeadingConstraint = fieldTitleLabel.leadingAnchor
            .constraint(equalTo: textFieldView.leadingAnchor,constant: TitlePositions.t0.x)

        titleTopConstraint = fieldTitleLabel.topAnchor
            .constraint(equalTo: textFieldView.topAnchor,constant: TitlePositions.t0.y)

        NSLayoutConstraint.activate([ titleLeadingConstraint!, titleTopConstraint! ])
    }

    func addTheme() {
        backgroundColor = .clear
    }
}

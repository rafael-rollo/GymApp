//
//  TextField.swift
//  GymApp
//
//  Created by rafael.rollo on 12/11/21.
//

import UIKit

class TextInput: UIView {

    private lazy var fieldTitleLabel: UIButton = {
        let label = UIButton() // just to have the content inset support, sorry!
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        label.titleLabel?.font = .openSans(.bold, size: 12)
        label.setTitleColor(.shipGray, for: .normal)
        label.backgroundColor = .white
        label.isUserInteractionEnabled = false
        return label
    }()

    private lazy var textField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = .openSans(size: 12)
        field.textColor = .shipGray
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

    var title: String? {
        didSet {
            textField.placeholder = title
            fieldTitleLabel.setTitle(title, for: .normal)
        }
    }

    var isSecureTextEntry: Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecureTextEntry
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

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
            textField.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 12),
            textField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -12),
            textField.centerYAnchor.constraint(equalTo: textFieldView.centerYAnchor, constant: -1)
        ])

        NSLayoutConstraint.activate([
            fieldTitleLabel.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: -10),
            fieldTitleLabel.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 16)
        ])
    }

    func addTheme() {
        backgroundColor = .clear
    }
}

//
//  Strike.swift
//  GymApp
//
//  Created by rafael.rollo on 16/11/21.
//

import UIKit

class Strike: UIView {

    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(.bold, size: 32)
        label.textColor = .blueViolet
        return label
    }()

    private lazy var strikeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(.bold, size: 12)
        label.textColor = .secondaryLabel
        return label
    }()

    private lazy var containerView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            numberLabel, strikeLabel
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(from strike: StrikeData) {
        numberLabel.text = String(strike.number)
        strikeLabel.text = strike.label
    }
}

extension Strike: ViewCode {
    func addViews() {
        addSubview(containerView)
    }

    func addConstraints() {
        self.constrainSize(to: .init(width: 80, height: 80))
    }
}

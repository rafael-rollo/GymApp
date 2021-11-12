//
//  Button.swift
//  GymApp
//
//  Created by rafael.rollo on 12/11/21.
//

import UIKit

class Button: UIButton {

    struct Styles {
        static var primary = Styles(backgroundColor: .terracotta, tintColor: .white)
        static var secondary = Styles(backgroundColor: .shipGray, tintColor: .white)

        var backgroundColor: UIColor?
        var tintColor: UIColor?
    }

    private var height: CGFloat = 48

    var style: Styles = .primary {
        didSet {
            backgroundColor = style.backgroundColor
            tintColor = style.tintColor
        }
    }

    var title: String? {
        didSet {
            setTitle(title, for: .normal)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.backgroundColor = self?.style.backgroundColor?.withAlphaComponent(0.8)
        } completion: { [weak self] _ in
            self?.backgroundColor = self?.style.backgroundColor
        }

        super.touchesBegan(touches, with: event)
    }
}

extension Button: ViewCode {
    
    func addTheme() {
        style = .primary
        titleLabel?.font = .openSans(.bold, size: 14)
        layer.cornerRadius = self.height / 2
        layer.masksToBounds = true
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: self.height)
        ])
    }
    
}

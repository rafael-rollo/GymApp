//
//  MenuSectionHeader.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

class MenuSectionHeader: UIView {
    
    static let height: CGFloat = 60

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(.bold, size: 14)
        label.textColor = .shipGray
        return label
    }()

    var title: String? {
        didSet {
            label.text = title
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

extension MenuSectionHeader: ViewCode {
    func addViews() {
        addSubview(label)
    }

    func addConstraints() {
        constrainHeight(to: MenuSectionHeader.height)
        label.constrainToBottomAndSides(of: self, bottomMargin: 12, horizontalMargins: 24)
    }

    func addTheme() {
        backgroundColor = .white
    }
}

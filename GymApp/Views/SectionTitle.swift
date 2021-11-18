//
//  SectionTitle.swift
//  GymApp
//
//  Created by rafael.rollo on 16/11/21.
//

import UIKit

class SectionTitle: UIView {
    
    struct LayoutProps {
        static let height: CGFloat = 68
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(.bold, size: 12)
        label.textColor = .secondaryLabel
        return label
    }()

    var text: String? {
        didSet {
            titleLabel.text = text?.uppercased()
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

extension SectionTitle: ViewCode {
    
    func addTheme() {
        backgroundColor = .whisper
    }
    
    func addViews() {
        addSubview(titleLabel)
    }

    func addConstraints() {
        self.constrainHeight(to: LayoutProps.height)

        titleLabel.constrainToLeading(of: self, withMargin: 24)
        titleLabel.anchorToCenterY(of: self, withOffset: 4)
    }

}

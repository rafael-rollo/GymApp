//
//  MenuItemCell.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

class MenuItemCell: UITableViewCell, ReusableView {

    static let height: CGFloat = 70

    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return imageView
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .shipGray
        label.font = .openSans(size: 14)
        return label
    }()

    private lazy var navigationIndicatorIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var containerView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            iconView, label, navigationIndicatorIconView
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 24
        return stack
    }()

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(from item: MenuItem) {
        let iconColor: UIColor = .terracotta ?? .systemOrange

        iconView.image = UIImage(named: item.imageName)?
            .withTintColor(iconColor)

        label.text = item.title

        navigationIndicatorIconView.image = UIImage(named: "ArrowRightIcon")?
            .withTintColor(iconColor)
    }
}

extension MenuItemCell: ViewCode {
    
    func addTheme() {
        selectionStyle = .none
    }
    
    func addViews() {
        addSubview(containerView)
    }

    func addConstraints() {
        containerView.constrainTo(edgesOf: self,
                                  verticalMargins: 12,
                                  horizontalMargins: 24)

        navigationIndicatorIconView.constrainSize(to: .init(width: 20, height: 20))
    }

}

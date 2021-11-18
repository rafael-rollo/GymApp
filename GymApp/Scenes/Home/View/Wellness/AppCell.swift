//
//  AppCell.swift
//  GymApp
//
//  Created by rafael.rollo on 16/11/21.
//

import UIKit
import AlamofireImage

class AppCell: UICollectionViewCell, ReusableView {
    
    fileprivate struct LayoutProps {
        static let height: CGFloat = 42
        static let radius: CGFloat = 12
    }

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .linkWater
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(.bold, size: 12)
        label.textColor = .shipGray
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(size: 12)
        label.textColor = .shipGray
        label.numberOfLines = 1
        return label
    }()

    private lazy var titlesView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            titleLabel, subtitleLabel
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        return stack
    }()

    private lazy var containerView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            imageView, titlesView, UIView()
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stack.spacing = 16
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // Improve scrolling performance with an explicit shadowPath
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: LayoutProps.radius
        ).cgPath
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {

        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        layoutAttributes.frame.size.height = size.height

        layoutIfNeeded()
        return layoutAttributes
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
    }
    
    func setup(from app: WellnessAppData) {
        imageView.af.setImage(withURL: app.imageURI)
        titleLabel.text = app.title
        subtitleLabel.text = app.description
    }
}

extension AppCell: ViewCode {
    
    func addTheme() {
        backgroundColor = .white

        layer.masksToBounds = false
        layer.cornerRadius = LayoutProps.radius

        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.secondaryLabel.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    func addViews() {
        addSubview(containerView)
    }

    func addConstraints() {
        containerView.constrainTo(edgesOf: self)
        imageView.constrainWidth(to: LayoutProps.height)
    }

}

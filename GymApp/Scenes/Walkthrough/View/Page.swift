//
//  Page.swift
//  GymApp
//
//  Created by rafael.rollo on 11/11/21.
//

import UIKit

class Page: UIView {

    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(.bold, size: 24)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor.init(named: "Relax")
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(size: 16)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        return label
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(characterImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        return view
    }()

    var image: UIImage? {
        didSet {
            characterImageView.image = image
        }
    }

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
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

extension Page: ViewCode {
    func addViews() {
        addSubview(contentView)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])

        NSLayoutConstraint.activate([
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            characterImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -16),
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
}

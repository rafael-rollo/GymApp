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
        label.textColor = .blueViolet
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(size: 16)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .shipGray
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
        contentView.constrainTo(edgesOf: self, withHorizontalMarginsOf: 24)

        subtitleLabel.constrainToBottomAndSides(of: contentView)

        titleLabel.constrainHorizontallyTo(contentView)
        titleLabel.anchorAbove(subtitleLabel, withMarginOf: 16)

        characterImageView.anchorAbove(titleLabel, withMarginOf: 16)
    }
    
}

//
//  Banner.swift
//  GymApp
//
//  Created by rafael.rollo on 16/11/21.
//

import UIKit

class Banner: UIView {

    // MARK: - subviews
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(.bold, size: 16)
        label.textColor = .shipGray
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .openSans(size: 14)
        label.textColor = .shipGray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var callToActionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(.extrabold, size: 14)
        return label
    }()
    
    private lazy var infoView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [ UIView(),
            titleLabel,
            descriptionLabel,
            callToActionLabel
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 24, left: 24, bottom: 24, right: 24)
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 12
        return stack
    }()
    
    private lazy var textureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textureImageView)
        view.addSubview(infoView)
        return view
    }()
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var feedbackLayer: CALayer = .init()
    
    private lazy var feedbackAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue = UIColor.clear.cgColor
        animation.toValue = UIColor.white.withAlphaComponent(0.4).cgColor
        animation.duration = 0.1
        return animation
    }()
    
    // MARK: - properties
    var onTap: (() -> Void)?

    // MARK: - view lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
        let tapRecognizer = UITapGestureRecognizer(target: self,
                                                   action: #selector(bannerTapped(_:)))
        addGestureRecognizer(tapRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        feedbackLayer.frame = bounds
    }
    
    // MARK: - view methods
    func setup(from bannerInfo: BannerData) {
        titleLabel.text = bannerInfo.title
        descriptionLabel.text = bannerInfo.description
        callToActionLabel.text = bannerInfo.callToAction
        
        backgroundView.backgroundColor = UIColor(named: bannerInfo.backgroundColor)
        callToActionLabel.textColor = UIColor(named: bannerInfo.callToActionFontColor)
        
        textureImageView.image = UIImage(named: bannerInfo.backgroundImageName)
        characterImageView.image = UIImage(named: bannerInfo.characterImageName)
    }
    
    @objc private func bannerTapped(_ sender: UIView) {
        feedbackLayer.add(feedbackAnimation, forKey: "feedbackAnimation")

        CATransaction.begin()
        onTap?()
        CATransaction.commit()
    }
}

extension Banner: ViewCode {
    
    func addTheme() {
        layer.insertSublayer(feedbackLayer, above: backgroundView.layer)
    }
    
    func addViews() {
        addSubview(backgroundView)
        addSubview(characterImageView)
    }
    
    func addConstraints() {
        backgroundView.constrainToTopAndSides(of: self)
        backgroundView.constrainHeight(referencedBy: self, withRatio: 0.9)
    
        textureImageView.constrainVertically(to: backgroundView)
        textureImageView.constrainToTrailing(of: backgroundView)
     
        characterImageView.constrainToBottomAndTrailing(of: self)
        
        infoView.constrainVertically(to: backgroundView)
        infoView.constrainToLeading(of: backgroundView)
        infoView.constrainWidth(referencedBy: backgroundView, withRatio: 0.67)
    }

}

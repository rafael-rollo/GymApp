//
//  WellnessApps.swift
//  GymApp
//
//  Created by rafael.rollo on 16/11/21.
//

import UIKit
import Lottie

protocol WellnessAppsDelegate: AnyObject {
    func appDidSelect(_ app: WellnessAppData)
}

class WellnessApps: UIView {

    fileprivate struct LayoutProps {
        static let height: CGFloat = 240
    }
    
    // MARK: - subviews
    private lazy var skeletonAnimationView: AnimationView = {
        let animation = AnimationView(name: "BannerSkeleton")
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.contentMode = .scaleToFill
        animation.loopMode = .loop
        animation.animationSpeed = 1.5
        animation.play()
        return animation
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(.bold, size: 14)
        label.textColor = .shipGray
        label.text = "Apps included in your plan"
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(size: 12)
        label.textColor = .shipGray
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.text = "Enjoy premium access to our digital partners to take care of your body, mind, and mood"
        return label
    }()
    
    private lazy var titlesView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel,
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 92)
        view.spacing = 16
        return view
    }()

    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.67, height: 74)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        return layout
    }()

    private lazy var appsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(AppCell.self, forCellWithReuseIdentifier: AppCell.reuseId)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    private lazy var containerView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            titlesView,
            appsCollectionView,
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.backgroundColor = .terracotta?.withAlphaComponent(0.2)
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 32, left: 0, bottom: 32, right: 0)
        view.spacing = 16
        return view
    }()

    // MARK: - properties
    var apps: [WellnessAppData] = [] {
        didSet {
            self.load(apps)
        }
    }
    
    weak var delegate: WellnessAppsDelegate?

    // MARK: - view lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func load(_ apps: [WellnessAppData]) {
        appsCollectionView.reloadData()
        transitionAnimating()
    }

    private func transitionAnimating() {
        let transition: (() -> Void)? = { [weak self] in
            guard let self = self else { return }

            self.skeletonAnimationView.removeFromSuperview()

            self.addSubview(self.containerView)
            self.containerView.constrainTo(edgesOf: self)
        }

        UIView.transition(
            with: self,
            duration: 0.5,
            options: .transitionCrossDissolve,
            animations: transition,
            completion: nil
        )
    }
}

extension WellnessApps: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppCell.reuseId, for: indexPath)
                as? AppCell else {
            fatalError("Provide an appropriate cell for the app list view")
        }

        cell.setup(from: apps[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let app = apps[indexPath.row]
        delegate?.appDidSelect(app)
    }
    
}

extension WellnessApps: ViewCode {
    
    func addTheme() {
        backgroundColor = .clear
    }
    
    func addViews() {
        self.addSubview(skeletonAnimationView)
    }

    func addConstraints() {
        self.constrainHeight(to: LayoutProps.height)
        skeletonAnimationView.constrainTo(edgesOf: self)
    }

}

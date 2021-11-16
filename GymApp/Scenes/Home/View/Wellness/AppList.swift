//
//  AppList.swift
//  GymApp
//
//  Created by rafael.rollo on 16/11/21.
//

import UIKit

class AppList: UIView {

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.72, height: 74)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(AppCell.self, forCellWithReuseIdentifier: AppCell.reuseId)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    var apps: [WellnessAppData] = [] {
        didSet {
            collectionView.reloadData()
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

extension AppList: UICollectionViewDelegate, UICollectionViewDataSource {
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
}

extension AppList: ViewCode {
    
    func addTheme() {
        backgroundColor = .clear
    }
    
    func addViews() {
        addSubview(collectionView)
    }

    func addConstraints() {
        collectionView.constrainTo(edgesOf: self)
    }

}

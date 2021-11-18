//
//  ExploreViewController.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

class ExploreViewController: UIViewController {

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(.bold, size: 14)
        label.text = "Explore Scene!"
        return label
    }()
    
    private lazy var sectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(size: 12)
        return label
    }()
    
    var navigationParams: [String : Any]? {
        didSet {
            guard let navigationParams = navigationParams else { return }
            self.navigationParamsDidSet(navigationParams)
        }
    }

    override func loadView() {
        super.loadView()
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func navigationParamsDidSet(_ navigationParams: [String : Any]) {
        sectionLabel.text = navigationParams["ref"] as? String
    }
}

extension ExploreViewController: ViewCode {
    
    func addTheme() {
        view.backgroundColor = .white
    }
    
    func addViews() {
        view.addSubview(label)
        view.addSubview(sectionLabel)
    }

    func addConstraints() {
        label.anchorToCenter(of: view)
        
        sectionLabel.anchorBelow(of: label, withMargin: 24)
        sectionLabel.anchorToCenterX(of: label)
    }

}

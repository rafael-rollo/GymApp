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

    init() {
        super.init(nibName: nil, bundle: nil)

        title = "Explore"
        tabBarItem.image = .init(named: "ExploreIcon")
        tabBarItem.selectedImage = .init(named: "ExploreFilledIcon")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ExploreViewController: ViewCode {
    
    func addTheme() {
        view.backgroundColor = .white
    }
    
    func addViews() {
        view.addSubview(label)
    }

    func addConstraints() {
        label.anchorToCenter(of: view)
    }

}

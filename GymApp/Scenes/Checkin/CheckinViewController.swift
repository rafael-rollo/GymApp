//
//  CheckinViewController.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

class CheckinViewController: UIViewController {

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(.bold, size: 14)
        label.text = "Check-in Scene!"
        return label
    }()

    init() {
        super.init(nibName: nil, bundle: nil)

        title = "Check-in"
        tabBarItem.image = .init(named: "CheckinIcon")
        tabBarItem.selectedImage = .init(named: "CheckinFilledIcon")
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

extension CheckinViewController: ViewCode {
    
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

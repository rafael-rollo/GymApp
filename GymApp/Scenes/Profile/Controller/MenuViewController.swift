//
//  MenuViewController.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

class MenuViewController: UIViewController {

    fileprivate struct LayoutProps {
        static let topBarHeight: CGFloat = 50
    }

    private lazy var backButton: UIButton = {
        let image = UIImage(named: "ArrowLeftIcon")?
            .withTintColor(.terracotta ?? .systemOrange)

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .shipGray
        label.font = .openSans(.bold, size: 14)
        label.text = title
        return label
    }()

    private lazy var topBarBottomBorder: CALayer = {
        let width: CGFloat = UIScreen.main.bounds.width
        let thickness: CGFloat = 0.5

        let border = CALayer()
        border.frame = CGRect(x:0, y: LayoutProps.topBarHeight - thickness,
                              width: width, height: thickness)
        border.backgroundColor = UIColor.tertiaryLabel.cgColor
        return border
    }()

    private lazy var topBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.layer.addSublayer(topBarBottomBorder)
        view.addSubview(titleLabel)
        view.addSubview(backButton)
        return view
    }()

    private lazy var itemsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuItemCell.self, forCellReuseIdentifier: MenuItemCell.reuseId)
        tableView.backgroundColor = .white
        tableView.sectionFooterHeight = .leastNormalMagnitude
        tableView.isScrollEnabled = false

        let dumbFooterView = UIView()
        tableView.tableFooterView = dumbFooterView
        return tableView
    }()

    private lazy var containerStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            topBarView, itemsTableView
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()

    private var items: [MenuItem] = []
    private var flowDelegate: ProfileFlowDelegate

    init(items: [MenuItem], flowDelegate: ProfileFlowDelegate) {
        self.items = items
        self.flowDelegate = flowDelegate

        super.init(nibName: nil, bundle: nil)
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

        backButton.addTarget(self,
                             action: #selector(backButtonTapped(_:)),
                             for: .touchUpInside)
    }

    @objc private func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MenuItemCell.height
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemCell.reuseId, for: indexPath) as? MenuItemCell else {
            fatalError("Provide an appropriate cell for the menu")
        }

        let item = items[indexPath.row]
        cell.setup(from: item)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let item = items[indexPath.row]
        flowDelegate.menuItemDidSelect(item)
    }
}

extension MenuViewController: ViewCodeController {
    func addViews() {
        view.addSubview(containerStackView)
    }

    func addConstraints() {
        containerStackView.constrainTo(safeEdgesOf: view)

        topBarView.constrainHeight(to: LayoutProps.topBarHeight)
        titleLabel.anchorToCenter(of: topBarView)

        backButton.constrainToLeading(of: topBarView, withMargin: 24)
        backButton.anchorToCenterY(of: topBarView)
        backButton.constrainSize(to: .init(width: 24, height: 24))
    }

    func addTheme() {
        view.backgroundColor = .white
    }
}

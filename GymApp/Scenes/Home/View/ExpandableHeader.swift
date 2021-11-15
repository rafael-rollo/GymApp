//
//  ExpandableHeader.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit

struct MenuItem {
    var imageName: String
    var title: String
    var externalLink: String?
    var onPress: () -> Void
}

struct MenuSection {
    var title: String
    var items: [MenuItem]
}

class ExpandableHeader: UIView {
    
    // MARK: - subviews
    private lazy var profileImageView: UIImageView = {
        let image = UIImage(named: "ProfilePicture")

        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        imageView.backgroundColor = .blue
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 26
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(.bold, size: 16)
        label.textColor = .shipGray
        label.text = "Rafael"
        return label
    }()

    private lazy var planLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(size: 10)
        label.textColor = .secondaryLabel
        label.text = "GymApp - Platinum"
        return label
    }()

    private lazy var gymappIdLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(size: 10)
        label.textColor = .secondaryLabel
        label.text = "GymApp ID: 1900916044063"
        return label
    }()

    private lazy var profileInfoPanel: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            nameLabel, planLabel, gymappIdLabel
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false

        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()

    private var arrowDownImage: UIImage? {
        return UIImage(named: "ArrowDownIcon")?
            .withTintColor(.shipGray ?? .secondaryLabel)
    }

    private var arrowUpImage: UIImage? {
        return UIImage(named: "ArrowUpIcon")?
            .withTintColor(.shipGray ?? .secondaryLabel)
    }

    private lazy var toggleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(arrowDownImage, for: .normal)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return button
    }()

    private lazy var baseContentView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            profileImageView, profileInfoPanel, toggleButton
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false

        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 12
        return stack
    }()
    
    private lazy var wrapperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(baseContentView)
        view.layer.zPosition = 100
        return view
    }()

    private lazy var menu: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isHidden = true
        tableView.sectionFooterHeight = .leastNormalMagnitude
        tableView.backgroundColor = .clear
        return tableView
    }()

    // MARK: - properties
    override var bounds: CGRect {
        didSet {
            dropShadow()
        }
    }

    var heightConstraint: NSLayoutConstraint?

    var height: CGFloat {
        let statusBarHeight = UIApplication.shared.windows
            .filter {$0.isKeyWindow}.first?.windowScene?
            .statusBarManager?.statusBarFrame.height ?? 0

        return 76 + statusBarHeight
    }
    
    var radius: CGFloat { return 12 }

    var isExpanded: Bool = false
    
    var menuItems: [MenuSection] = [
        MenuSection(title: "Account", items: [
            MenuItem(imageName: "GearIcon", title: "Plan management", externalLink: "https://gympass.com/", onPress: {
                print("coordinator, please open \(MenuItem.self)")
            }),
            MenuItem(imageName: "GearIcon", title: "Plan management", externalLink: "https://gympass.com/", onPress: {
                print("coordinator, please open \(MenuItem.self)")
            }),
            MenuItem(imageName: "GearIcon", title: "Plan management", externalLink: "https://gympass.com/", onPress: {
                print("coordinator, please open \(MenuItem.self)")
            }),
            MenuItem(imageName: "GearIcon", title: "Plan management", externalLink: "https://gympass.com/", onPress: {
                print("coordinator, please open \(MenuItem.self)")
            })
        ]),
        MenuSection(title: "About Gympass", items: [
            MenuItem(imageName: "BellIcon", title: "Notifications", externalLink: "https://gympass.com/", onPress: {
                print("coordinator, please open \(MenuItem.self)")
            }),
            MenuItem(imageName: "BellIcon", title: "Notifications", externalLink: "https://gympass.com/", onPress: {
                print("coordinator, please open \(MenuItem.self)")
            }),
            MenuItem(imageName: "BellIcon", title: "Notifications", externalLink: "https://gympass.com/", onPress: {
                print("coordinator, please open \(MenuItem.self)")
            }),
            MenuItem(imageName: "BellIcon", title: "Notifications", externalLink: "https://gympass.com/", onPress: {
                print("coordinator, please open \(MenuItem.self)")
            })
        ])
    ]

    // MARK: - view lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()

        toggleButton.addTarget(self,
                               action: #selector(toggleButtonPressed(_:)),
                               for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        animatedShadowPath()
    }

    // MARK: - methods
    private func dropShadow() {
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.secondaryLabel.cgColor
        layer.shadowOffset = .init(width: 0, height: 5)
    }

    private func animatedShadowPath() {
        let currentPath = layer.shadowPath
        let newPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath

        guard let heightAnimation = layer.animation(forKey: "bounds.size")
                as? CABasicAnimation else {
            layer.shadowPath = newPath
            return
        }

        let pathAnimation = CABasicAnimation(keyPath: "shadowPath")
        pathAnimation.duration = heightAnimation.duration
        pathAnimation.timingFunction = heightAnimation.timingFunction
        pathAnimation.fromValue = currentPath
        pathAnimation.toValue = newPath

        layer.add(pathAnimation, forKey: "shadowPath")
        layer.shadowPath = newPath
    }

    @objc private func toggleButtonPressed(_ sender: UIButton) {
        guard let superview = superview else {
            return
        }

        isExpanded = !isExpanded

        let toggleImage = isExpanded ? arrowUpImage : arrowDownImage
        toggleButton.setImage(toggleImage, for: .normal)
        
        menu.isHidden = !isExpanded

        heightConstraint?.constant = isExpanded
            ? superview.bounds.height
            : height
        UIView.animate(withDuration: 0.5) {
            superview.layoutIfNeeded()
        }

        menu.isHidden = !isExpanded
    }
    
}

// MARK: - menu data source
extension ExpandableHeader: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuItems.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MenuSectionHeader.height
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = MenuSectionHeader()
        header.title = menuItems[section].title
        return header
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems[section].items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = menuItems[indexPath.section]
            .items[indexPath.row]
            .title
        return cell
    }
    
}

// MARK: - view code
extension ExpandableHeader: ViewCode {
    
    func addTheme() {
        backgroundColor = .white
        layer.zPosition = 100
        layer.masksToBounds = false
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func addViews() {
        addSubview(wrapperView)
        addSubview(menu)
    }
    
    func addConstraints() {
        heightConstraint = constrainHeight(to: height)
        
        wrapperView.constrainToTopAndSides(of: self)
        wrapperView.constrainHeight(to: height)
        
        baseContentView.constrainToTop(of: wrapperView, notchSafe: true)
        baseContentView.constrainHorizontally(to: wrapperView, withMargins: 24)
        baseContentView.constrainHeight(to: 68)

        profileImageView.constrainSize(to: .init(width: 52, height: 52))
        toggleButton.constrainSize(to: .init(width: 24, height: 24))
        
        menu.anchorBelow(of: wrapperView)
        menu.constrainToBottomAndSides(of: self)
    }

}

//
//  ExpandableHeader.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit
import Accelerate

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
    
    private lazy var contentContainerView: UIStackView = {
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
    
    private lazy var baseContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.zPosition = 100
        
        view.layer.masksToBounds = false
        view.layer.cornerRadius = radius
        view.layer.shadowRadius = 8.0
        view.layer.shadowOpacity = 0
        view.layer.shadowColor = UIColor.secondaryLabel.cgColor
        view.layer.shadowOffset = .init(width: 0, height: 5)

        view.addSubview(contentContainerView)
        return view
    }()
    
    private lazy var appVersionLabel: UILabel = {
        let label = UILabel()
        label.font = .openSans(size: 14)
        label.textColor = .secondaryLabel

        guard let appVersion = Bundle.main.releaseVersionNumber,
              let appBuild = Bundle.main.buildVersionNumber else {
            return label
        }

        label.text = "App version: \(appVersion) (\(appBuild))"
        label.sizeToFit()
        return label
    }()

    private lazy var logoutButton: UIButton = {
        let atributedTitle = NSAttributedString(string: "Log out", attributes: [
            .foregroundColor: UIColor.terracotta ?? .systemOrange,
            .font: UIFont.openSans(.bold, size: 14)
        ])

        let button = UIButton()
        button.setAttributedTitle(atributedTitle, for: .normal)
        button.sizeToFit()
        return button
    }()

    private lazy var menuFooterView: UIView = {
        let view = UIView()
        view.frame.size.height = 130

        view.addSubview(appVersionLabel)
        appVersionLabel.frame.origin = .init(x: 24, y: 24)

        view.addSubview(logoutButton)
        logoutButton.frame.origin = .init(x: 24, y: 62)

        return view
    }()
    
    private lazy var menuTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MenuItemCell.self, forCellReuseIdentifier: MenuItemCell.reuseId)
        tableView.sectionFooterHeight = .leastNormalMagnitude
        tableView.backgroundColor = .clear
        tableView.tableFooterView = menuFooterView
        return tableView
    }()
    
    // MARK: - properties
    override var bounds: CGRect {
        didSet {
            dropShadow()
        }
    }
    
    var heightConstraint: NSLayoutConstraint?
    var menuTopConstraint: NSLayoutConstraint?
    
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
            MenuItem(imageName: "PeopleIcon", title: "Dependents", externalLink: "https://gympass.com/", onPress: {
                print("coordinator, please open \(MenuItem.self)")
            }),
            MenuItem(imageName: "PersonIcon", title: "Edit profile", externalLink: "https://gympass.com/", onPress: {
                print("coordinator, please open \(MenuItem.self)")
            }),
            MenuItem(imageName: "WalletIcon", title: "Payments", externalLink: "https://gympass.com/", onPress: {
                print("coordinator, please open \(MenuItem.self)")
            }),
            MenuItem(imageName: "HistoryIcon", title: "Check-in history", externalLink: "https://gympass.com/", onPress: {
                print("coordinator, please open \(MenuItem.self)")
            })
        ]),
        MenuSection(title: "About Gympass", items: [
            MenuItem(imageName: "BellIcon", title: "Notifications", externalLink: "https://gympass.com/", onPress: {
                print("coordinator, please open \(MenuItem.self)")
            }),
            MenuItem(imageName: "HelpIcon", title: "Help center", externalLink: "https://gympass.com/", onPress: {
                print("coordinator, please open \(MenuItem.self)")
            }),
            MenuItem(imageName: "DumbbellIcon", title: "Refer a facility", externalLink: "https://gympass.com/", onPress: {
                print("coordinator, please open \(MenuItem.self)")
            }),
            MenuItem(imageName: "PadlockIcon", title: "Privacy and security", externalLink: "https://gympass.com/", onPress: {
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
        drawShadowPath()
    }
    
    // MARK: - methods
    private func dropShadow() {
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.secondaryLabel.cgColor
        layer.shadowOffset = .init(width: 0, height: 5)
    }
    
    private func drawShadowPath() {
        let currentPath = layer.shadowPath
        let newPath = UIBezierPath(roundedRect: bounds,
                                   cornerRadius: radius).cgPath
        
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
        baseContainerView.layer.shadowPath = UIBezierPath(
            roundedRect: baseContainerView.bounds,
            cornerRadius: radius
        ).cgPath
    }
    
    private func animateBaseContainerViewShadow(byInterpolating contentOffset: Double) {
        let maxOffsetLimit = 20.0
        let proportionalOffset = contentOffset / maxOffsetLimit

        let minOpacity = 0.0, maxOpacity = 0.3

        let result = vDSP.linearInterpolate(elementsOf: [minOpacity, maxOpacity],
                                            using: [0, min(1, proportionalOffset), 1])
        let opacity = Float(result[1])
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.baseContainerView.layer.shadowOpacity = opacity
        }
    }
    
    @objc private func toggleButtonPressed(_ sender: UIButton) {
        guard let superview = superview else {
            return
        }
        
        isExpanded.toggle()
        
        let toggleImage = isExpanded ? arrowUpImage : arrowDownImage
        toggleButton.setImage(toggleImage, for: .normal)
        
        if !isExpanded {
            menuTableView.setContentOffset(.zero, animated: false)
        }
        
        heightConstraint?.constant = isExpanded
            ? superview.bounds.height
            : height
        
        menuTopConstraint?.constant = isExpanded
            ? 0
            : -UIScreen.main.bounds.height
        
        UIView.animate(withDuration: 0.5) {
            superview.layoutIfNeeded()
        }
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MenuItemCell.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemCell.reuseId, for: indexPath) as? MenuItemCell else {
            fatalError("Provide an appropriate cell for the menu")
        }
        
        let item = menuItems[indexPath.section].items[indexPath.row]
        cell.setup(from: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        debugPrint("section [\(indexPath.section)] - row[\(indexPath.row)]")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = Double(scrollView.contentOffset.y)
        animateBaseContainerViewShadow(byInterpolating: yOffset)
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
        addSubview(menuTableView)
        addSubview(baseContainerView)
    }
    
    func addConstraints() {
        heightConstraint = constrainHeight(to: height)
        
        baseContainerView.constrainToTopAndSides(of: self)
        baseContainerView.constrainHeight(to: height)
        
        contentContainerView.constrainToTop(of: baseContainerView, notchSafe: true)
        contentContainerView.constrainHorizontally(to: baseContainerView, withMargins: 24)
        contentContainerView.constrainHeight(to: 68)
        
        profileImageView.constrainSize(to: .init(width: 52, height: 52))
        toggleButton.constrainSize(to: .init(width: 24, height: 24))
        
        menuTopConstraint = menuTableView.anchorBelow(of: baseContainerView)
        menuTableView.constrainToBottomAndSides(of: self)
    }
    
}
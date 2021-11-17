//
//  ProfileViewController.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit
import Accelerate

protocol ProfileFlowDelegate: AnyObject {
    func menuItemDidSelect(_ item: MenuItem)
}

class ProfileViewController: UIViewController {
    
    // MARK: - layout properties
    fileprivate struct LayoutProps {
        static let defaultRadius: CGFloat = 12
        static let defaultHeight: CGFloat = {
            let statusBarHeight = UIApplication.shared.windows
                .filter {$0.isKeyWindow}.first?.windowScene?
                .statusBarManager?.statusBarFrame.height ?? 0
                
            return 76 + statusBarHeight
        }()
    }
    
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
        view.layer.cornerRadius = LayoutProps.defaultRadius
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
    private var isExpanded: Bool = false
    private final var menuItems: [MenuItems] = MenuItems.allItems
    
    private var heightConstraint: NSLayoutConstraint?
    private var menuTopConstraint: NSLayoutConstraint?
    
    private var flowDelegate: ProfileFlowDelegate
    
    // MARK: - view lifecycle
    init(flowDelegate: ProfileFlowDelegate) {
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
        
        toggleButton.addTarget(self,
                               action: #selector(toggleButtonPressed(_:)),
                               for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        drawShadowPath()
    }
    
    // MARK: - view methods
    private func drawShadowPath() {
        let currentPath = view.layer.shadowPath
        let newPath = UIBezierPath(
            roundedRect: view.bounds,
            cornerRadius: LayoutProps.defaultRadius
        ).cgPath
        
        guard let heightAnimation = view.layer.animation(forKey: "bounds.size")
                as? CABasicAnimation else {
            view.layer.shadowPath = newPath
            return
        }
        
        let pathAnimation = CABasicAnimation(keyPath: "shadowPath")
        pathAnimation.duration = heightAnimation.duration
        pathAnimation.timingFunction = heightAnimation.timingFunction
        pathAnimation.fromValue = currentPath
        pathAnimation.toValue = newPath
        view.layer.add(pathAnimation, forKey: "shadowPath")
        
        view.layer.shadowPath = newPath
        baseContainerView.layer.shadowPath = UIBezierPath(
            roundedRect: baseContainerView.bounds,
            cornerRadius: LayoutProps.defaultRadius
        ).cgPath
    }
    
    @objc private func toggleButtonPressed(_ sender: UIButton) {
        guard let superview = view.superview else {
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
            : LayoutProps.defaultHeight
        
        menuTopConstraint?.constant = isExpanded
            ? 0
            : -UIScreen.main.bounds.height
        
        UIView.animate(withDuration: 0.5) {
            superview.layoutIfNeeded()
        }
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
}

extension ProfileViewController: ViewCode {
    func addViews() {
        view.addSubview(menuTableView)
        view.addSubview(baseContainerView)
    }
    
    func addConstraints() {
        heightConstraint = view.constrainHeight(to: LayoutProps.defaultHeight)
        
        baseContainerView.constrainToTopAndSides(of: view)
        baseContainerView.constrainHeight(to: LayoutProps.defaultHeight)
        
        contentContainerView.constrainToTop(of: baseContainerView, notchSafe: true)
        contentContainerView.constrainHorizontally(to: baseContainerView, withMargins: 24)
        contentContainerView.constrainHeight(to: 68)
        
        profileImageView.constrainSize(to: .init(width: 52, height: 52))
        toggleButton.constrainSize(to: .init(width: 24, height: 24))
        
        menuTopConstraint = menuTableView.anchorBelow(of: baseContainerView)
        menuTableView.constrainToBottomAndSides(of: view)
    }
    
    func addTheme() {
        view.backgroundColor = .white
        view.layer.zPosition = 100
        
        // shaping the root view
        view.layer.masksToBounds = false
        view.layer.cornerRadius = LayoutProps.defaultRadius
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        // shadowing the root view
        view.layer.shadowColor = UIColor.secondaryLabel.cgColor
        view.layer.shadowOffset = .init(width: 0, height: 5)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 8.0
    }
}

// MARK: - menu table view data source
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
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
        
        let item = menuItems[indexPath.section].items[indexPath.row]
        flowDelegate.menuItemDidSelect(item)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = Double(scrollView.contentOffset.y)
        animateBaseContainerViewShadow(byInterpolating: yOffset)
    }
}

//
//  LocationPermissionViewController.swift
//  GymApp
//
//  Created by rafael.rollo on 11/11/21.
//

import UIKit
import CoreLocation

protocol LocationPermissionViewControllerDelegate: AnyObject {
    func locationPermissionViewController(_ viewController: LocationPermissionViewController, didRequest authorizationStatus: CLAuthorizationStatus)
}

class LocationPermissionViewController: UIViewController {

    // MARK: - subviews
    private lazy var shape: AnimatedShape = {
        let shape = AnimatedShape()
        shape.translatesAutoresizingMaskIntoConstraints = false
        return shape
    }()
    
    private lazy var logo: UIImageView = {
        let logo = UIImage(named: "GymAppLogo")?.withTintColor(.white)
        let imageView = UIImageView(image: logo)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var markerImageView: UIImageView = {
        let logo = UIImage(named: "MarkerIcon")?
                    .withTintColor(.shipGray ?? .secondaryLabel)
        let imageView = UIImageView(image: logo)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(.bold, size: 24)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .blueViolet
        label.text = "Share location"
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(size: 16)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .shipGray
        label.text = "Share your location with Gym.app to find out what gyms and studios are nearby."
        return label
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(markerImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        return view
    }()

    private lazy var allowPermissionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "Terracotta")
        button.tintColor = .white
        button.layer.cornerRadius = 24
        button.layer.masksToBounds = true
        button.titleLabel?.font = .openSans(.bold, size: 14)
        button.setTitle("Continue", for: .normal)
        return button
    }()
    
    // MARK: - properties
    private lazy var locationManager = CLLocationManager()
    
    weak var delegate: LocationPermissionViewControllerDelegate?

    // MARK: - view lifecycle
    init(delegate: LocationPermissionViewControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
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
        shape.animate()
        
        locationManager.delegate = self
        
        allowPermissionButton.addTarget(self,
                                        action: #selector(showPermissionRequestDialog(_:)),
                                        for: .touchUpInside)
    }
    
    // MARK: - view methods
    @objc private func showPermissionRequestDialog(_ sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func completeRequest(with status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            delegate?.locationPermissionViewController(self, didRequest: status)

        } else {
            let warning = "Some features require the phone's location access to work properly."

            showAlert(withTitle: "Warning", message: warning) { [weak self] _ in
                self?.delegate?.locationPermissionViewController(self!, didRequest: status)
            }
        }

        Storage.locationPermissionHasAlreadyBeenRequested = true
    }
    
}

extension LocationPermissionViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // avoiding initial status load
        guard status != .notDetermined else { return }

        // give us some time to complete the location dialog's fade-out transition
        Thread.sleep(forTimeInterval: 0.5)
        completeRequest(with: status)
    }
}

extension LocationPermissionViewController: ViewCode {
    
    func addTheme() {
        view.backgroundColor = .white
    }
    
    func addViews() {
        view.addSubview(shape)
        view.addSubview(logo)
        view.addSubview(contentView)
        view.addSubview(allowPermissionButton)
    }

    func addConstraints() {
        let shapeXOffset = shape.bounds.width * 0.37
        let shapeYOffset = shape.bounds.height - view.bounds.height * 0.3

        NSLayoutConstraint.activate([
            shape.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: -shapeXOffset),
            shape.topAnchor.constraint(equalTo: view.topAnchor,
                                       constant: -shapeYOffset)
        ])
        
        NSLayoutConstraint.activate([
            logo.widthAnchor.constraint(equalToConstant: 120),
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            logo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        ])

        NSLayoutConstraint.activate([
            allowPermissionButton.heightAnchor.constraint(equalToConstant: 48),
            allowPermissionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            allowPermissionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            allowPermissionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48)
        ])

        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            contentView.leadingAnchor.constraint(equalTo: allowPermissionButton.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: allowPermissionButton.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: allowPermissionButton.topAnchor, constant: -48)
        ])

        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            markerImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -16),
            markerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }

}

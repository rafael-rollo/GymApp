//
//  WebViewController.swift
//  GymApp
//
//  Created by rafael.rollo on 15/11/21.
//

import UIKit
import WebKit

protocol WebViewFlowDelegate: AnyObject {
    func webViewDidClose()
}

class WebViewController: UIViewController {

    // MARK: - subviews
    private lazy var closeButton: UIButton = {
        let image = UIImage(named: "CloseIcon")?
            .withTintColor(.terracotta ?? .systemOrange)

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        return button
    }()

    private lazy var buttonWrapperView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .trailing
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        stack.addArrangedSubview(closeButton)
        return stack
    }()

    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.trackTintColor = .terracotta?.withAlphaComponent(0.3)
        progressView.progressTintColor = .terracotta
        return progressView
    }()

    private lazy var topBarStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            buttonWrapperView, progressView
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.setContentHuggingPriority(.defaultHigh, for: .vertical)
        stack.spacing = 12
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        return stack
    }()

    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        return webView
    }()

    private lazy var containerStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            topBarStackView, webView
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()

    // MARK: - properties
    private var path: URL
    
    private var flowDelegate: WebViewFlowDelegate

    // MARK: - view lifecycle
    init(path: URL, flowDelegate: WebViewFlowDelegate) {
        self.path = path
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

        closeButton.addTarget(self,
                              action: #selector(closeButtonTapped(_:)),
                              for: .touchUpInside)
        browse()
    }

    // MARK: - view methods
    @objc private func closeButtonTapped(_ sender: UIButton) {
        flowDelegate.webViewDidClose()
    }

    private func browse() {
        webView.load(URLRequest(url: self.path))
        webView.allowsBackForwardNavigationGestures = true

        webView.addObserver(self, forKeyPath: "estimatedProgress",
                            options: .new, context: nil)
    }
}

// MARK: - view code
extension WebViewController: ViewCodeController {
    
    func addTheme() {
        view.backgroundColor = .white
    }

    func addViews() {
        view.addSubview(containerStackView)
    }

    func addConstraints() {
        containerStackView.constrainTo(safeEdgesOf: view)
        progressView.constrainHeight(to: 2)
    }

}

extension WebViewController: WKNavigationDelegate {

    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }

}

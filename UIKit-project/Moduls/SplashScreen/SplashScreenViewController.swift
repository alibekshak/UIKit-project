//
//  SplashScreenViewController.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 06.01.2026.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    var onFinish: (() -> Void)?
    
    private var didAnimate = false
    private var finishTask: Task<Void, Never>?
    
    // MARK: - UI
    
    private let logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "xmark.triangle.circle.square")
        image.contentMode = .scaleAspectFit
        image.tintColor = .label
        image.translatesAutoresizingMaskIntoConstraints = false
        image.alpha = 0
        image.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        image.isAccessibilityElement = true
        image.accessibilityLabel = "App logo"
        
        return image
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        label.text = "Project UIKit"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0
        label.isAccessibilityElement = true
        label.accessibilityLabel = "Project UIKit"
        
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
        makeConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !didAnimate else { return }
        didAnimate = true
        animateSplash()
        scheduleFinish()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        finishTask?.cancel()
        finishTask = nil
    }
    
    deinit {
        finishTask?.cancel()
    }
    
    private func setup() {
        view.addSubview(logoImageView)
        view.addSubview(textLabel)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            logoImageView.widthAnchor.constraint(equalToConstant: 140),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            
            
            textLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
    }
    
    // MARK: - Animation
    
    private func animateSplash() {
        if UIAccessibility.isReduceMotionEnabled {
            logoImageView.alpha = 1
            logoImageView.transform = .identity
            textLabel.alpha = 1
            return
        }
        
        UIView.animateKeyframes(withDuration: 0.6, delay: 0.05, options: [.calculationModeCubic]) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.7) {
                self.logoImageView.alpha = 1
                self.logoImageView.transform = .identity
            }
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.6) {
                self.textLabel.alpha = 1
            }
        }
    }
    
    private func scheduleFinish() {
        finishTask = Task { [weak self] in
            try? await Task.sleep(nanoseconds: 1_200_000_000)
            guard !Task.isCancelled else { return }
            await MainActor.run {
                self?.onFinish?()
            }
        }
    }
}

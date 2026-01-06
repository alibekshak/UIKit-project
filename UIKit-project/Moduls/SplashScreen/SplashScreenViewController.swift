//
//  SplashScreenViewController.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 06.01.2026.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    var onFinish: (() -> Void)?
    
    // MARK: - UI
    
    private let logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "xmark.triangle.circle.square")
        image.contentMode = .scaleAspectFit
        image.tintColor = .label
        image.translatesAutoresizingMaskIntoConstraints = false
        image.alpha = 0
        image.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
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
        animateSplash()
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
        UIView.animate(withDuration: 0.5, delay: 0.05, options: [.curveEaseOut]) {
            self.logoImageView.alpha = 1
            self.logoImageView.transform = .identity
        }

        UIView.animate(withDuration: 0.45, delay: 0.18, options: [.curveEaseOut]) {
            self.textLabel.alpha = 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
            self?.onFinish?()
        }
    }
}

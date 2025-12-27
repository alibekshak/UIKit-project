//
//  SettingsViewController.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 04.11.2025.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var profileButton: UIButton = {
        let button = makeSettingsButton(
            title: "Профиль",
            systemImage: "person.circle"
        )
        button.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
        return button
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = makeSettingsButton(
            title: "Избранное",
            systemImage: "heart"
        )
        button.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        return button
    }()
    
    private lazy var exitButton: UIButton = {
        let button = makeSettingsButton(
            title: "Выйти",
            systemImage: "iphone.and.arrow.forward.outward",
            isExitButton: true
        )
        button.addTarget(self, action: #selector(didTapExit), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [profileButton, favoriteButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        title = "Настройки"
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        view.addSubview(exitButton)
    }
    
    private func setupConstraints() {
        let guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16),
            
            exitButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -34),
            exitButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            exitButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - Button Factory
    
    private func makeSettingsButton(
        title: String,
        systemImage: String,
        isExitButton: Bool = false
    ) -> UIButton {
        let button = UIButton(type: .system)
        
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: systemImage)
        config.imagePlacement = .leading
        config.imagePadding = 12
        config.title = title
        config.baseForegroundColor = isExitButton ? .red : .label
        config.titleAlignment = .leading
        config.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 12, bottom: 16, trailing: 12)
        
        button.configuration = config
        button.contentHorizontalAlignment = .leading
        button.backgroundColor = isExitButton ? .systemRed.withAlphaComponent(0.3) : .systemGray6
        button.layer.cornerRadius = 12
        
        return button
    }
    
    // MARK: - Actions
    
    @objc private func didTapProfile() {
        print("профиль")
    }
    
    @objc private func didTapFavorite() {
        print("избранное")
    }
    
    @objc private func didTapExit() {
        showLogoutAlert()
    }
    
    private func showLogoutAlert() {
        let alert = UIAlertController(
            title: "Выход",
            message: "Вы уверены, что хотите выйти?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(UIAlertAction(title: "Выйти", style: .destructive, handler: { _ in
            print("Выход !")
        }))
        
        present(alert, animated: true)
    }
}

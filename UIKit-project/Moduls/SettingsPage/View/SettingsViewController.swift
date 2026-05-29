//
//  SettingsViewController.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 04.11.2025.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var output: SettingsPageOutput?
    
    // MARK: - UI
    
    private let contentView = UIView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.make(
            font: .systemFont(ofSize: 32, weight: .bold),
            color: .label
        )
        label.text = "Настройки"
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel.make(
            font: .systemFont(ofSize: 14, weight: .regular),
            color: .secondaryLabel
        )
        label.text = "Управление профилем и избранным"
        
        return label
    }()
    
    private lazy var profileButton: UIButton = {
        let button = makeSettingsButton(
            title: "Профиль",
            subtitle: "Личные данные и информация",
            systemImage: "person.crop.circle.fill",
            tintColor: .systemBlue
        )
        button.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
        return button
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = makeSettingsButton(
            title: "Избранное",
            subtitle: "Ваши сохранённые элементы",
            systemImage: "heart.fill",
            tintColor: .systemPink
        )
        button.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        return button
    }()
    
    private lazy var exitButton: UIButton = {
        let button = makeSettingsButton(
            title: "Выйти",
            subtitle: "Завершить текущую сессию",
            systemImage: "rectangle.portrait.and.arrow.right",
            tintColor: .systemRed,
            isDestructive: true
        )
        button.addTarget(self, action: #selector(didTapExit), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
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
        view.backgroundColor = UIColor.systemGroupedBackground
        
        navigationItem.largeTitleDisplayMode = .never
        title = ""
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .clear
        
        view.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(buttonsStackView)
        contentView.addSubview(exitButton)
    }
    
    private func setupConstraints() {
        let guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: guide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            buttonsStackView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 28),
            buttonsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            buttonsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            exitButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            exitButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            exitButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -20)
        ])
    }
    
    
    // MARK: - Button Factory
    
    private func makeSettingsButton(
        title: String,
        subtitle: String,
        systemImage: String,
        tintColor: UIColor,
        isDestructive: Bool = false
    ) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .leading
        button.tintColor = tintColor
        
        button.configuration = makeButtonConfiguration(
            title: title,
            subtitle: subtitle,
            systemImage: systemImage,
            isDestructive: isDestructive
        )
        button.heightAnchor.constraint(greaterThanOrEqualToConstant: 72).isActive = true
        
        setupButtonShadow(button, isDestructive: isDestructive)
        setupChevronIfNeeded(for: button, isDestructive: isDestructive)
        setupButtonStateHandler(button, isDestructive: isDestructive)
        
        return button
    }
    
    private func makeButtonConfiguration(
        title: String,
        subtitle: String,
        systemImage: String,
        isDestructive: Bool
    ) -> UIButton.Configuration {
        var config = UIButton.Configuration.plain()

        config.title = title
        config.subtitle = subtitle
        config.image = UIImage(systemName: systemImage)
        config.imagePlacement = .leading
        config.imagePadding = 14
        config.titlePadding = 4
        config.baseForegroundColor = isDestructive ? .systemRed : .label
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 14,
            leading: 16,
            bottom: 14,
            trailing: 16
        )

        config.background.backgroundColor = buttonBackgroundColor(isDestructive)
        config.background.cornerRadius = 16
        config.background.strokeWidth = 1
        config.background.strokeColor = buttonBorderColor(isDestructive)

        config.attributedTitle = AttributedString(
            title,
            attributes: AttributeContainer([
                .font: UIFont.systemFont(ofSize: 16, weight: .semibold)
            ])
        )

        config.attributedSubtitle = AttributedString(
            subtitle,
            attributes: AttributeContainer([
                .font: UIFont.systemFont(ofSize: 13, weight: .regular),
                .foregroundColor: isDestructive
                    ? UIColor.systemRed.withAlphaComponent(0.8)
                    : UIColor.secondaryLabel
            ])
        )

        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(
            pointSize: 20,
            weight: .semibold
        )

        return config
    }
    
    
    private func buttonBackgroundColor(_ isDestructive: Bool) -> UIColor {
        isDestructive ? .clear : .secondarySystemGroupedBackground
    }

    private func buttonBorderColor(_ isDestructive: Bool) -> UIColor {
        isDestructive
            ? UIColor.systemRed.withAlphaComponent(0.4)
            : UIColor.separator.withAlphaComponent(0.15)
    }
    
    private func setupButtonShadow(_ button: UIButton, isDestructive: Bool) {
        guard !isDestructive else { return }

        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.04
        button.layer.shadowRadius = 8
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    private func setupChevronIfNeeded(for button: UIButton, isDestructive: Bool) {
        guard !isDestructive else { return }
        
        let chevron = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevron.tintColor = .tertiaryLabel
        chevron.translatesAutoresizingMaskIntoConstraints = false
        
        button.addSubview(chevron)
        
        NSLayoutConstraint.activate([
            chevron.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            chevron.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupButtonStateHandler(_ button: UIButton, isDestructive: Bool) {
        let backgroundColor = buttonBackgroundColor(isDestructive)

        button.configurationUpdateHandler = { button in
            guard var config = button.configuration else { return }

            if button.state == .highlighted {
                config.background.backgroundColor = isDestructive
                    ? UIColor.systemRed.withAlphaComponent(0.08)
                    : backgroundColor.withAlphaComponent(0.75)

                button.transform = CGAffineTransform(scaleX: 0.985, y: 0.985)
            } else {
                config.background.backgroundColor = backgroundColor
                button.transform = .identity
            }

            button.configuration = config
        }
    }
    
    // MARK: - Actions
    
    @objc private func didTapProfile() {
        output?.navigateToProfilePage()
    }
    
    @objc private func didTapFavorite() {
        output?.navigateToFavoritePage()
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
            self.output?.logout()
        }))
        
        present(alert, animated: true)
    }
}

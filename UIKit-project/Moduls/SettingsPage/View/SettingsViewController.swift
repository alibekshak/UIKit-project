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
        let lable = UILabel()
        lable.text = "Настройки"
        lable.font = .systemFont(ofSize: 32, weight: .bold)
        lable.textColor = .label
        lable.translatesAutoresizingMaskIntoConstraints = true
        
        return lable
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let lable = UILabel()
        lable.text = "Управление профилем и избранным"
        lable.font = .systemFont(ofSize: 14, weight: .regular)
        lable.textColor = .secondaryLabel
        lable.translatesAutoresizingMaskIntoConstraints = false
        
        return lable
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
        
        var config = UIButton.Configuration.plain()
        config.title = title
        config.subtitle = subtitle
        config.image = UIImage(systemName: systemImage)
        config.imagePlacement = .leading
        config.imagePadding = 14
        config.titlePadding = 4
        config.baseForegroundColor = isDestructive ? .systemRed : .label
        config.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 16, bottom: 18, trailing: 16)
        
        let backgroundColor = isDestructive
            ? UIColor.systemRed.withAlphaComponent(0.08)
            : UIColor.secondarySystemGroupedBackground
        
        config.background.backgroundColor = backgroundColor
        config.background.cornerRadius = 18
        config.background.strokeWidth = 1
        config.background.strokeColor = isDestructive
            ? UIColor.systemRed.withAlphaComponent(0.12)
            : UIColor.separator.withAlphaComponent(0.18)
        
        let titleAttributes = AttributeContainer([
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold)
        ])
        
        let subtitleAttributes = AttributeContainer([
            .font: UIFont.systemFont(ofSize: 13, weight: .regular),
            .foregroundColor: isDestructive ? UIColor.systemRed.withAlphaComponent(0.8) : UIColor.secondaryLabel
        ])
        
        config.attributedTitle = AttributedString(title, attributes: titleAttributes)
        config.attributedSubtitle = AttributedString(subtitle, attributes: subtitleAttributes)
        
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        config.preferredSymbolConfigurationForImage = symbolConfig
        
        button.configuration = config
        button.contentHorizontalAlignment = .leading
        button.tintColor = tintColor
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.05
        button.layer.shadowRadius = 10
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(greaterThanOrEqualToConstant: 76)
        ])
        
        button.configurationUpdateHandler = { button in
            guard var updatedConfig = button.configuration else { return }
            
            switch button.state {
            case .highlighted:
                updatedConfig.background.backgroundColor = backgroundColor.withAlphaComponent(0.75)
                button.transform = CGAffineTransform(scaleX: 0.985, y: 0.985)
            default:
                updatedConfig.background.backgroundColor = backgroundColor
                button.transform = .identity
            }
            
            button.configuration = updatedConfig
        }
        
        return button
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
            print("Выход !")
        }))
        
        present(alert, animated: true)
    }
}

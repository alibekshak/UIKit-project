//
//  ProfilePageViewController.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 17.01.2026.
//

import UIKit

class ProfilePageViewController: UIViewController {
    
    var output: ProfilePageOutput?
    
    // MARK: - UI
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Add name"
        textField.font = .systemFont(ofSize: 16, weight: .semibold)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray3
        textField.clearButtonMode = .whileEditing
        textField.autocapitalizationType = .allCharacters
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                textField,
                saveButton
            ]
        )
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.tintColor = .systemGray
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var clearButton:  UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: "Clear",
            style: .plain,
            target: self,
            action: #selector(clearTapped)
        )
        button.tintColor = .red
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = clearButton
        textField.returnKeyType = .done
        textField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        setupView()
        bindViewModel()
        setupActions()
        updateButtonsState()
    }
    
    // MARK: Private methods
    
    private func setupView() {
        view.addSubview(stackView)
        
        textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        saveButton.setContentHuggingPriority(.required, for: .horizontal)
        saveButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])

    }
    
    private func bindViewModel() {
        textField.text = output?.username
    }
    
    private func setupActions() {
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }
    
    private func updateButtonsState() {
        let trimmed = (textField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        saveButton.isEnabled = !trimmed.isEmpty
        clearButton.isEnabled = !trimmed.isEmpty
        saveButton.alpha = saveButton.isEnabled ? 1 : 0.5
    }
    
    // MARK: - Actions
    
    @objc private func textChanged() {
        output?.username = textField.text ?? ""
        updateButtonsState()
    }
    
    @objc private func saveTapped() {
        view.endEditing(true)
        updateButtonsState()
        output?.saveUserName()
    }
    
    @objc private func clearTapped() {
        output?.clearUserName()
        textField.text = ""
        output?.username = ""
        updateButtonsState()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ProfilePageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        saveTapped()
        return true
    }
}

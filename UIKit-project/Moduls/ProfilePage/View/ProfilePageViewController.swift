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
    
    private let nameField = makeTextField(
        placeholder: "Add name",
        keyboard: .default,
        capitalization: .words
    )
    
    private let phoneField = makeTextField(
        placeholder: "Add phone number",
        keyboard: .phonePad,
        capitalization: .none
    )
    
    private let emailField = makeTextField(
        placeholder: "Add email",
        keyboard: .emailAddress,
        capitalization: .none
    )
    
    private lazy var fieldsStackView: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                nameField,
                phoneField,
                emailField
            ]
        )
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                fieldsStackView,
                saveButton
            ]
        )
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save all", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.tintColor = .systemGray
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var clearButton:  UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: "Clear all",
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
        nameField.returnKeyType = .done
        nameField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        setupView()
        bindViewModel()
        setupActions()
        updateButtonsState()
    }
    
    // MARK: Private methods
    
    private static func makeTextField(
        placeholder: String,
        keyboard: UIKeyboardType = .default,
        capitalization: UITextAutocapitalizationType = .none
    ) -> UITextField {
        
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.font = .systemFont(ofSize: 16, weight: .semibold)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .secondarySystemBackground
        textField.clearButtonMode = .whileEditing
        textField.autocapitalizationType = capitalization
        textField.autocorrectionType = .no
        textField.keyboardType = keyboard
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }
    
    private func setupView() {
        view.addSubview(stackView)
        
        [nameField, phoneField, emailField].forEach { $0.heightAnchor.constraint(equalToConstant: 44).isActive = true }
        saveButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func bindViewModel() {
        nameField.text = output?.username
        phoneField.text = output?.phoneNumber
        emailField.text = output?.email
    }
    
    private func setupActions() {
        nameField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        phoneField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        emailField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }
    
    private func updateButtonsState() {
        let hasValues =
        !(nameField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        || !(phoneField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        || !(emailField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        saveButton.isEnabled = hasValues
        clearButton.isEnabled = hasValues
        saveButton.alpha = hasValues ? 1 : 0.5
    }
    
    func syncedFields() {
        output?.username = nameField.text ?? ""
        output?.phoneNumber = phoneField.text ?? ""
        output?.email = emailField.text ?? ""
    }
    
    // MARK: - Actions
    
    @objc private func textChanged(_ textField: UITextField) {
        switch textField {
        case nameField:
            output?.username = textField.text ?? ""
        case phoneField:
            output?.phoneNumber = textField.text ?? ""
        case emailField:
            output?.email = textField.text ?? ""
        default:
            break
        }
        
        updateButtonsState()
    }
    
    @objc private func saveTapped() {
        view.endEditing(true)
        syncedFields()
        
        output?.saveUserName()
        output?.savePhoneNumber()
        output?.savePhoneNumber()
        
        updateButtonsState()
    }
    
    @objc private func clearTapped() {
        output?.clearUserName()
        output?.clearPhoneNumber()
        output?.clearEmail()
        
        nameField.text = ""
        phoneField.text = ""
        emailField.text = ""
        
        syncedFields()
        updateButtonsState()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ProfilePageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField:
            phoneField.becomeFirstResponder()
            
        case phoneField:
            emailField.becomeFirstResponder()
            
        case emailField:
            textField.resignFirstResponder()
            saveTapped()
            
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}

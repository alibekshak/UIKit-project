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
        textField.font = .systemFont(ofSize: 14, weight: .semibold)
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [saveButton, clearButton])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fillEqually
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
    
    let clearButton:  UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
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
        view.addSubview(textField)
        view.addSubview(buttonsStack)

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 44),

            buttonsStack.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            buttonsStack.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            buttonsStack.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            buttonsStack.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    private func bindViewModel() {
        textField.text = output?.username
    }
    
    private func setupActions() {
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
    }
    
    private func updateButtonsState() {
        let trimmed = (textField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        saveButton.isEnabled = !trimmed.isEmpty
        clearButton.isEnabled = !(textField.text ?? "").isEmpty

        saveButton.alpha = saveButton.isEnabled ? 1 : 0.4
        clearButton.alpha = clearButton.isEnabled ? 1 : 0.4
    }
    
    // MARK: - Actions
    
    @objc private func textChanged() {
        output?.username = textField.text ?? ""
        updateButtonsState()
    }
    
    @objc private func saveTapped() {
        view.endEditing(true)
        output?.saveUserName()
        updateButtonsState()
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

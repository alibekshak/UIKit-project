//
//  ProfilePageViewController.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 17.01.2026.
//

import UIKit

class ProfilePageViewController: UIViewController {
    
    // MARK: - UI
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Add name"
        textField.font = .systemFont(ofSize: 14, weight: .semibold)
        
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
}

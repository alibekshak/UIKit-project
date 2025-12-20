//
//  BaseViewController.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 02.12.2025.
//

import UIKit

class BaseViewController: UIViewController {
    
    private var loaderView = LoaderView()
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupLoaderView()
    }
    
    // MARK: - Public methods
    
    func showLoading() {
        view.bringSubviewToFront(loaderView)
        loaderView.startAnimation()
    }
    
    func hideLoading() {
        loaderView.stopAnimation()
    }
    
    // MARK: - Private methods
    
    private func setupLoaderView() {
        guard let containerView = navigationController?.view ?? view else { return }
        
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        loaderView.alpha = 0.0
        containerView.addSubview(loaderView)
        
        NSLayoutConstraint.activate([
            loaderView.topAnchor.constraint(equalTo: containerView.topAnchor),
            loaderView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            loaderView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            loaderView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}

extension BaseViewController {
    func showAlert(
        title: String? = nil,
    ) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: "Ok",
                style: UIAlertAction.Style.default
            )
        )
        
        present(alert, animated: true, completion: nil)
    }
}

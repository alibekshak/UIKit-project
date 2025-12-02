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
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        loaderView.alpha = 0.0
        view.addSubview(loaderView)
        
        NSLayoutConstraint.activate([
            loaderView.topAnchor.constraint(equalTo: view.topAnchor),
            loaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loaderView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

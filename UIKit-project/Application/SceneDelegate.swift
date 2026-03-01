//
//  SceneDelegate.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 03.11.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = splashScreen()
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func splashScreen() -> UIViewController {
        let splash = SplashScreenViewController()
        splash.onFinish = { [weak self] in
            guard let window = self?.window else { return }
            UIView.transition(with: window, duration: 0.35, options: .transitionCrossDissolve) {
                window.rootViewController = TabBarController()
            }
        }
        
        return splash
    }
}

